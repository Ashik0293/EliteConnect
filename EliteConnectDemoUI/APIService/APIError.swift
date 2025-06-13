//
//  APIerror.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//



import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case httpError(Int)
    case decodingFailed
    case encodingFailed(Error)
    case other(Error) 

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was returned from the server."
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .decodingFailed:
            return "Failed to decode the server response."
        case .encodingFailed(let error):
            return "Failed to encode data: \(error.localizedDescription)"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
