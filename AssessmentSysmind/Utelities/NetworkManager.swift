//
//  NetworkManager.swift
//  AssessmentSysmind
//
//  Created by Ganpat Jangir on 16/01/25.
//

import Foundation

//MARK: - Network Custom Error Enum.
enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case urlSessionFailed
}

//MARK: - Network Manager.
class NetworkManager {
    func fetchData(completion: @escaping (Result<[UserModel], NetworkError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if error != nil {
                completion(.failure(.urlSessionFailed))
            }else {
                if let rawData = data {
                    do {
                        let users = try JSONDecoder().decode([UserModel].self, from: rawData)
                        completion(.success(users))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                }else {
                    completion(.failure(.noData))
                }
            }
        }
        task.resume()
    }
}
