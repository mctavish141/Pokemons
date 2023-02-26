//
//  ApiService.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

protocol PokemonService {
    func getPokemons(url: String?, completion: @escaping (Result<PokemonList, Error>) -> ())
    func getPokemonDetails(url: String, completion: @escaping (Result<PokemonDetails, Error>) -> ())
    func getPokemonSpecies(id: Int, completion: @escaping (Result<PokemonSpecies, Error>) -> ())
    func getPokemonImage(url: String, completion: @escaping (Result<Data, Error>) -> ())
}
