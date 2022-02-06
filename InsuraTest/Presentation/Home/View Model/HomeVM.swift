//
//  HomeVM.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class HomeVM {
    func getPost(completionHandler: @escaping (Result<PostResponseModel, ErrorType>)->Void){
        guard let url = URL(string: Constant.API.postURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        APIService.request(model: NilRequestBody(), responseModel: PostResponseModel.self, url: url, method: .GET) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
