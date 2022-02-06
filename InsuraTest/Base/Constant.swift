//
//  Constant.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

enum EnvironmentType {
    case dev
    case prod
}

class Environtment {
    static var env : EnvironmentType = .dev
}

class Constant {
    
    static private let baseURL : String = {
        switch Environtment.env{
        case .dev:
            return "https://jsonplaceholder.typicode.com"
        case .prod:
            return "https://jsonplaceholder.typicode.com"
        }
    }()
    
    fileprivate enum path: String {
        case users = "/users"
        case posts = "/posts"
        case comments = "/comments"
    }
    
    class API{
        static let userURL = baseURL + path.users.rawValue
        static let postURL = baseURL + path.posts.rawValue
        static let commentUrl : String = {
            guard let userData = UserDataPreference().read() else { return "" }
            return baseURL + path.posts.rawValue + "/\(userData.id)" + path.comments.rawValue
        }()
    }
}
