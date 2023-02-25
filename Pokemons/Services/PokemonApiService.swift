//
//  PokemonApiService.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

class PokemonApiService: PokemonService {
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getPokemons(completion: @escaping (Result<PokemonList, Error>) -> ()) {
        let url = Endpoint.pokemons.fullPath()
        let method = NetworkRequestMethod.get
        let responseType = PokemonList.self
        
        apiClient.makeRequest(url: url, method: method, responseType: responseType, completion: completion)
    }
    
    func getPokemonDetails(url: String, completion: @escaping (Result<PokemonDetails, Error>) -> ()) {
        let method = NetworkRequestMethod.get
        let responseType = PokemonDetails.self
        
        apiClient.makeRequest(url: url, method: method, responseType: responseType, completion: completion)
    }
    
    func getPokemonSpecies(id: Int, completion: @escaping (Result<PokemonSpecies, Error>) -> ()) {
        let url = Endpoint.pokemonSpecies.fullPath() + "/" + "\(id)"
        let method = NetworkRequestMethod.get
        let responseType = PokemonSpecies.self
        
        apiClient.makeRequest(url: url, method: method, responseType: responseType, completion: completion)
    }
    
    func getPokemonImage(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: url) else {
                completion(.failure(ApiClientError.invalidURL))
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                completion(.failure(ApiClientError.invalidURL))
                return
            }
            
            completion(.success(data))
        }
    }
}
