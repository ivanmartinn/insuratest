//
//  DetailVM.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class DetailVM {
    func getComment(completionHandler: @escaping (Result<CommentResponseModel, ErrorType>)->Void){
        guard let url = URL(string: Constant.API.commentUrl) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        APIService.request(model: NilRequestBody(), responseModel: CommentResponseModel.self, url: url, method: .GET) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
