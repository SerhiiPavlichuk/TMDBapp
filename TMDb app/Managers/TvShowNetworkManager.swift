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

   func requestVideos(_ tvShowId: String, completion: @escaping((String) -> ())) {

    let url = Constants.network.tvShowPath + "/\(tvShowId)" + Constants.network.keyForVideos

       AF.request(url).responseJSON { response in

           let decoder = JSONDecoder()

           if let data = try? decoder.decode(Trailers.self, from: response.data!) {
               let videoKey =  data.results?.first?.key ?? ""
               completion(videoKey)
           }
       }
   }
}
