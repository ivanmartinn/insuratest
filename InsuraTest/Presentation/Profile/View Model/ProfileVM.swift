//
//  ProfileVM.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class ProfileVM {
    func getUserProfile(completionHandler: @escaping (Result<User, ErrorType>)->Void){
        guard let userData = UserDataPreference().read() else {
            completionHandler(.failure(ErrorType.dataError))
            return
        }
        guard let url = URL(string: Constant.API.userURL+"/\(userData.id)") else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        APIService.request(model: NilRequestBody(), responseModel: User.self, url: url, method: .GET) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
