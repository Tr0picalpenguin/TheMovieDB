//
//  NetworkController.swift
//  TheMovieDB
//
//  Created by Scott Cox on 8/10/22.
//

import Foundation
import UIKit

class NetworkController {
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    
    static func fetchMovieDictionary(with searchTerm: String, completion: @escaping(Result<MovieDictionary, ResultError>) -> Void) {
        guard let baseURL = baseURL else {return}
        completion(.failure(.invalidURL(baseURL)))
        
        var urlComponents = URLComponents.init(url: baseURL, resolvingAgainstBaseURL: true)
        let apiKeyQuery = URLQueryItem(name: "api_key", value: "820708be1a1f7f76083138998b15b1d5")
        let searchQuery = URLQueryItem(name: "query", value: searchTerm)
        urlComponents?.queryItems = [apiKeyQuery, searchQuery]
        
        guard let finalUrl = urlComponents?.url else {return}
        completion(.failure(.invalidURL(finalUrl)))
        
        URLSession.shared.dataTask(with: finalUrl) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                print("Encountered Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let movieDictionary = try JSONDecoder().decode(MovieDictionary.self, from: data)
                completion(.success(movieDictionary))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchPosterPath(with posterPathString: String, completion: @escaping(Result<UIImage, ResultError>) -> Void) {
        guard let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500") else {return}
        let finalURL = baseImageURL.appendingPathComponent(posterPathString)
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Encountered Error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let posterImage = UIImage(data: data) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(posterImage))
        }.resume()
    }
} // End of class
