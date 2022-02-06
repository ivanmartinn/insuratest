//
//  PostResponseModel.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias PostResponseModel = [Post]
