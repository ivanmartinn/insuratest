//
//  APIService.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation

class APIService {
    
    static func request<T: Codable, U: Codable>(model: T, responseModel: U.Type, url: URL, method: Method, header: HeaderType = .basic, completionHandler: @escaping (Result<U, ErrorType>)->Void){
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if header == .authorization {
            guard let token = UserData.shared.token else {
                completionHandler(.failure(ErrorType.missingToken))
                return
            }
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        if !(model is NilRequestBody) {
            request.httpBody = try? JSONEncoder().encode(model)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completionHandler(.failure(ErrorType.failedRequest(description: requestError.localizedDescription)))
                return
            }
            
            if let data = data{
                do {
                    let decoder = JSONDecoder()
                    //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model: U = try decoder.decode(U.self, from: data)
                    completionHandler(.success(model))
                } catch let error {
                    debugPrint("\n=====HTTPResponseError=====")
                    debugPrint("RESPONSE FROM \(error.localizedDescription)")
                    debugPrint("====================\n")
                    completionHandler(.failure(ErrorType.responseModelParsingError))
                }
            }else{
                completionHandler(.failure(ErrorType.dataError))
            }
        }
        
        dataTask.resume()
    }
}
