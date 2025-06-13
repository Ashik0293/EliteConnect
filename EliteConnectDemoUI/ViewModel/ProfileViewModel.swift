//
//  ProfileViewModel.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import Foundation

//APIService to fetch profiles
class ProfileViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    @Published var errorMessage: String?
    @Published var toastMessage: String? = ""
    @Published var isLoading: Bool = false
    @Published var showToast: Bool = false

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func loadProfiles() {
        
        isLoading = true
        errorMessage = nil
        toastMessage = ""
        
        apiService.fetchProfiles { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let fetchedProfiles):
                self.showToastMessage("Profile Data Loaded")
                self.profiles = fetchedProfiles
            case .failure(let error):
                self.showToastMessage(error.localizedDescription)
                print("Error fetching profiles: \(error.localizedDescription)")
            }
        }
    }
    
    func showToastMessage(_ message: String) {
        self.toastMessage = message
        self.showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
            self.toastMessage = ""
        }
    }
}
