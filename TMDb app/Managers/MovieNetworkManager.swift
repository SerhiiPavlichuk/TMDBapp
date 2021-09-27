//
//  MovieNetworkManager.swift
//  TMDb app
//
//  Created by admin on 23.09.2021.
//

import Foundation
import Alamofire

struct MovieNetworkManager {
    
    static let shared = MovieNetworkManager()
    
    func requestTrendingMovies(completion: @escaping(([Movie]) -> ())) {
        
        let url = Constants.network.trendingMoviePath + "=\(Constants.network.apiKey)"
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {
                let movies = data.movies ?? []
                completion(movies)
            }
        }
    }
    
    func requestActors(movieId: Movie?, completion: @escaping(([Cast]?) -> ())) {
        
        if let movieIdForUrl = movieId?.id{
            let url = Constants.network.moviePath + "/\(movieIdForUrl)" + Constants.network.movieActorsPath
            
            AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(CastAndCrewResult.self, from: responce.data!) {
                    let actors = data.cast ?? []
                    completion(actors)
                }
            }
        }
    }
    
    func requestVideos(_ movieId: String, completion: @escaping((String) -> ())) {
        
        let url = Constants.network.moviePath + "/\(movieId)" + Constants.network.keyForVideos
        AF.request(url).responseJSON { response in
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(Trailers.self, from: response.data!) {
                let videoId =  data.results?.first?.key ?? ""
                completion(videoId)
            }
        }
    }
}
