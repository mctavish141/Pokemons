//
//  ApiClient.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

enum NetworkRequestMethod: String {
    case get, post, put, delete
    
    var string: String {
        return rawValue.uppercased()
    }
}

enum ApiClientError: Error {
    case invalidURL
    case invalidParameters
}

enum Endpoint: String {
    private static let baseUrl = "https://pokeapi.co/api/v2"
    
    case pokemons = "/pokemon"
    case pokemonSpecies = "/pokemon-species"
    
    func fullPath() -> String {
        return Self.baseUrl + self.rawValue
    }
}

protocol ApiClient {
    func makeRequest<T: Decodable>(url: String,
                                   method: NetworkRequestMethod,
                                   parameters: [String: Any]?,
                                   headers: [String: String]?,
                                   responseType: T.Type,
                                   completion: @escaping (Result<T, Error>) -> ())
}

extension ApiClient {
    func makeRequest<T: Decodable>(url: String,
                                   method: NetworkRequestMethod,
                                   parameters: [String: Any]? = nil,
                                   headers: [String: String]? = nil,
                                   responseType: T.Type,
                                   completion: @escaping (Result<T, Error>) -> ()) {
        
        makeRequest(url: url, method: method, parameters: parameters, headers: headers, responseType: responseType, completion: completion)
    }
}
