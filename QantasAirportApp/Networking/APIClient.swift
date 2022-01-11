//
//  APIClient.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import UIKit

var baseUrlString = "https://api.qantas.com/flight/refData/airport"


final class APIClient {
    
    var baseUrl: URL = {
        return URL(string: baseUrlString)!
    }()

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Network Call
    
    func fetch<T: Decodable>(with url: URL?, page: Int?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request: URL = baseUrl
        
        // If URL exists use it
        if let url = url { request = url }
      
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.request))
                }
                return
            }
           
            // Check if http response is successful and data is safe
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let safeData = data
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.unknown))
                    }
                    return
            }
            switch statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let decodedData = try decoder.decode(dataType, from: safeData)

                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding))
                    }
                }
            default :
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
        }
        dataTask.resume()
    }
}

