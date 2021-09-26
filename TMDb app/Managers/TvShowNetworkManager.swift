//
//  TvShowNetworkManager.swift
//  TMDb app
//
//  Created by admin on 23.09.2021.
//

import Foundation
import Alamofire

struct TvShowNetworkManager {
    
    static let shared = TvShowNetworkManager()

    func requestTrendingTvShows(completion: @escaping(([TvShow]) -> ())) {
           
        let url = Constants.network.trendingTVShowPath + "=\(Constants.network.apiKey)"

           AF.request(url).responseJSON { responce in

               let decoder = JSONDecoder()

               if let data = try? decoder.decode(PopularTvShowResult.self, from: responce.data!) {

                   let tvShows = data.tvShows ?? []
                   completion(tvShows)
               }
           }
       }
    
//    func requestVideos(with id: String) {
//
//        let url = Constants.network.moviePath + "/\(id)" + Constants.network.keyForVideos
//
//        AF.request(url).responseJSON { responce in
//
//            let decoder = JSONDecoder()
//            guard let data = responce.data else { return }
//
//            if let data = try? decoder.decode(Trailers.self, from: data) {
//                if let videoId = data.results?.first?.key {
//                self.video = videoId
//            }
//        }
//    }
//}
//    func requestActors(with id: String) {
//
//        let url = Constants.network.moviePath + "/\(id)" + Constants.network.movieActorsPath
//
//                    AF.request(url).responseJSON { responce in
//                         let decoder = JSONDecoder()
//                         if let data = try? decoder.decode(Actors.self, from: responce.data!) {
//                             self.actors = data.actors ?? []
//
//
//                         }
//                     }
//            }
//
//}
//func requestTrendingMovies(completion: @escaping(([Movie]) -> ())) {
//
//       let url = Constants.network.defaultPath + "trending/movie/week?api_key=" + Constants.network.apiKey
//
//       AF.request(url).responseJSON { responce in
//
//           let decoder = JSONDecoder()
//
//           if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {
//
//               let movies = data.movies ?? []
//               completion(movies)
//           }
//       }
//   }
//
//   func requestTrendingActors(completion: @escaping(([Actor]) -> ())) {
//
//       let url = Constants.network.defaultPath + "person/popular?api_key=" + Constants.network.apiKey
//
//       AF.request(url).responseJSON { responce in
//
//           let decoder = JSONDecoder()
//
//           if let data = try? decoder.decode(PopularActorsResult.self, from: responce.data!) {
//               let actors = data.actors ?? []
//               completion(actors)
//           }
//       }
//   }
//
//   func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
//
//       let url = Constants.network.defaultPath + "movie/\(movieId)/videos?api_key=" + Constants.network.apiKey
//
//       AF.request(url).responseJSON { response in
//
//           let decoder = JSONDecoder()
//
//           if let data = try? decoder.decode(MovieVideosResult.self, from: response.data!) {
//               let videoKey =  data.videos?.first?.key ?? ""
//               completion(videoKey)
//           }
//       }
   }
