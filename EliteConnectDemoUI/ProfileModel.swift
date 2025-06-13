//
//  ProfileModel.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import Foundation

// MARK: - ProfilesResponse Model
struct ProfilesResponse: Codable {
    let responseCode: Int
    let message: String
    let profiles: [Profile]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case message
        case profiles
    }
}

// MARK: - Profile Model
struct Profile: Codable, Identifiable {
    let id: String
    let profileFirstName: String
    let profileLastName: String
    let profilePhoneNumber: String
    let profileEmail: String
    let profileJobTitle: String
    let profileCompanyName: String

    enum CodingKeys: String, CodingKey {
        case id = "profile_id"
        case profileFirstName = "profile_first_name"
        case profileLastName = "profile_last_name"
        case profilePhoneNumber = "profile_phone_number"
        case profileEmail = "profile_email"
        case profileJobTitle = "profile_job_title"
        case profileCompanyName = "profile_company_name"
    }
}
