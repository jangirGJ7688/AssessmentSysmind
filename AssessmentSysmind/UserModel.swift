//
//  UserModel.swift
//  AssessmentSysmind
//
//  Created by Ganpat Jangir on 16/01/25.
//

// MARK: - UserModel
struct UserModel: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: GeoLocation?
}

// MARK: - Geo
struct GeoLocation: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

