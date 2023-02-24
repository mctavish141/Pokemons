//
//  ApiClientURLSession.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

struct ApiClientURLSession: ApiClient {
    // MARK: - Make request
    
    func makeRequest<T>(url: String,
                        method: NetworkRequestMethod,
                        parameters: [String : Any]?,
                        headers: [String : String]?,
                        responseType: T.Type,
                        completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        
        guard let urlComponents = urlComponents(withURL: url, parameters: parameters) else {
            completion(.failure(ApiClientError.invalidURL))
            return
        }
        
        guard let finalUrl = urlComponents.url else {
            completion(.failure(ApiClientError.invalidParameters))
            return
        }
        
        var finalUrlString = finalUrl.absoluteString
        if finalUrlString.hasSuffix("?") {
            finalUrlString = finalUrlString.replacingOccurrences(of: "?", with: "")
        }
        
        guard let request = request(withURL: URL(string: finalUrlString)!, method: method, headers: headers, parameters: parameters) else {
            completion(.failure(ApiClientError.invalidParameters))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: - Private methods
    
    private func urlComponents(withURL url: String, parameters: [String : Any]?) -> URLComponents? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        urlComponents.queryItems = queryItems(from: parameters)
        
        return urlComponents
    }
    
    private func queryItems(from parameters: [String: Any]?) -> [URLQueryItem]? {
        var queryItems: [URLQueryItem] = []
        
        if let parameters = parameters {
            for (key, value) in parameters {
                guard let value = value as? CustomStringConvertible else {
                    return nil
                }
                
                queryItems.append(URLQueryItem(name: key, value: value.description))
            }
        }
        
        return queryItems
    }
    
    private func request(withURL url: URL, method: NetworkRequestMethod, headers: [String : String]? = nil, parameters: [String : Any]? = nil) -> URLRequest? {
        
        var newRequest: URLRequest?
        
        switch method {
        case .get:
            newRequest = request(withURL: url, headers: headers)
        default:
            newRequest = request(withURL: url, headers: headers, bodyParameters: parameters)
        }
        
        newRequest?.httpMethod = method.string
        
        return newRequest
    }
    
    private func request(withURL url: URL, headers: [String : String]?) -> URLRequest {
        var request = URLRequest(url: url)
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    private func request(withURL url: URL, headers: [String : String]?, bodyParameters: [String : Any]?) -> URLRequest? {
        
        var request = request(withURL: url, headers: headers)
        
        if let bodyParameters = bodyParameters {
            guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyParameters, options: []) else {
                return nil
            }
            
            request.httpBody = bodyData
        }
        
        return request
    }
}
