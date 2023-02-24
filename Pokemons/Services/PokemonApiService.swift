//
//  PokemonApiService.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

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
}
