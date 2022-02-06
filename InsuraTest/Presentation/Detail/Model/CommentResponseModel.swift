//
//  CommentResponseModel.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

struct Comment: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias CommentResponseModel = [Comment]
