//
//  APIservice.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//


import Foundation

// MARK: - APIServiceProtocol
protocol APIServiceProtocol {
    func fetchProfiles(completion: @escaping (Result<[Profile], Error>) -> Void)
}

// MARK: - APIService
class APIService: APIServiceProtocol {

    private let baseURL = "https://webapp.eliteconnect.biz/Fusionweb/fusion/api/get-profiles"

    // MARK: - APIService for fetchProfiles
    func fetchProfiles(completion: @escaping (Result<[Profile], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)

        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            print("Using cached data")
            let data = cachedResponse.data
            do {
                let profilesResponse = try JSONDecoder().decode(ProfilesResponse.self, from: data)
                completion(.success(profilesResponse.profiles))
                return
            } catch {
                print("Error decoding cached data: \(error.localizedDescription)")
            }
        }

        URLCache.shared.removeCachedResponse(for: request)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(APIError.other(error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    completion(.failure(APIError.httpError(statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }

                do {
                    let profilesResponse = try JSONDecoder().decode(ProfilesResponse.self, from: data)
                    let cachedURLResponse = CachedURLResponse(response: response!, data: data)
                    URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
                    completion(.success(profilesResponse.profiles))
                } catch {
                    completion(.failure(APIError.decodingFailed))
                }
            }
        }.resume()
    }
}
