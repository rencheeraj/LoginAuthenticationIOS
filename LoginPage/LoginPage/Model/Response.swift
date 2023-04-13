//
//  Response.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 13/04/23.
//

import Foundation

// MARK: - Response
struct ResponseModel: Codable {
    let refresh, access, username, firstname: String
    let lastname, email: String
}
