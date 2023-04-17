//
//  APIManager.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 13/04/23.
//

import Foundation
import Alamofire

enum APIErros : Error{
    case custom(message: String)
}
typealias Handler = (Swift.Result<Any?, APIErros>) -> Void
typealias ListHandler = (Swift.Result<Any?,APIErros>) -> Void

class APIManger{
    static let shareInstance = APIManger()
    // MARK: - Login
    func loginApiCalling(login : LoginModel, completionHandler : @escaping Handler){
        let headers: HTTPHeaders = [.contentType(ContentType.json.rawValue)
        ]
        
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ResponseModel.self, from: data!)
                    print(json)
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "Check Your Network Connectivity")))
                    }
                }
                catch{
                        print(error.localizedDescription)
                        completionHandler(.failure(.custom(message: "Please Try Again")))
                    }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again")))
            }
        }
    }
    
    // MARK: - DashBoard
    func detailImageList(token : String, completionHandler : @escaping ListHandler){
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token),.accept("application/json")
        ]
        AF.request(dashboard_url, method: .get, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        let json : [ImageListModel] = try JSONDecoder().decode([ImageListModel].self, from: data!)
                        print(json)
                        completionHandler(.success(json))
                    }else{
                        completionHandler(.failure(.custom(message: "Check Your Network Connectivity")))
                    }
                }
                catch{
                        print(error.localizedDescription)
                        completionHandler(.failure(.custom(message: "Please Try Again")))
                    }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again")))
            }
        }
    }
}
