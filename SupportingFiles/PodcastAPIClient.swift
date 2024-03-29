//
//  PodcastAPIClient.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func fetchPodcast(for searchQuery: String, completion: @escaping (Result<[Podcast], AppError>) ->()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "abba"
        let podcastEndpointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        guard let url = URL(string: podcastEndpointURL) else {
            completion(.failure(.badURL(podcastEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    // always decode top level struct from the model. If only 1 struct in the model, then we are decoding an array
                    let podcasts = try JSONDecoder().decode(PodcastArray.self, from: data)
                    completion(.success(podcasts.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postPodcast(podcast: Podcast, completion: @escaping (Result<Bool,AppError>) -> ()) {
        
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        // create a url
           guard let url = URL(string: endpointURLString) else {
             completion(.failure(.badURL(endpointURLString)))
             return
           }
        
        do {
            let data = try JSONEncoder().encode(podcast)
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = data
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                  case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                  case .success:
                    completion(.success(true))
                  }
                }
            
            
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    
    static func fetchFavoritePodcast(completion: @escaping (Result<[Podcast], AppError>) -> ()) {
        
        let favoriteURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: favoriteURLString) else {
            completion(.failure(.badURL(favoriteURLString)))
            return
        }
         let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                   let favotritePodcasts = try JSONDecoder().decode([Podcast].self, from: data)
                    completion(.success(favotritePodcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
