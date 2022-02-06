//
//  LoginVM.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class LoginVM {
    func getUsers(completionHandler: @escaping (Result<UserResponseModel, ErrorType>)->Void){
        guard let url = URL(string: Constant.API.userURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        APIService.request(model: NilRequestBody(), responseModel: UserResponseModel.self, url: url, method: .GET) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
