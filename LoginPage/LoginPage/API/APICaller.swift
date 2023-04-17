//
//  APICaller.swift
//  LoginPage
//
//  Created by Rencheeraj Mohan on 17/04/23.
//

import Foundation

import Foundation
final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func loginApiCalling(login: LoginModel, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        let url = URL(string: login_url)
        var request = URLRequest(url: url!)
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = ["username": login.username, "password":login.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ResponseModel.self, from: data)
                    print("Data: \(result)")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
    
}
