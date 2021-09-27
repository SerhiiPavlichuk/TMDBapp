//
//  TvShowDetailViewModel.swift
//  TMDb app
//
//  Created by admin on 26.09.2021.
//

import Foundation

class TvShowDetailViewModel {

    var tvShow: TvShow? = nil
    var video: String = String()
    
    func loadTrailer(_ tvShowId: String, completion: @escaping((String) -> ())) {
                
            MovieNetworkManager.shared.requestVideos(tvShowId, completion: { videoKey in
                
                self.video = videoKey
                completion(videoKey)
                })
            }
    
    func saveTvShowInRealm(_ movie: TvShow?, completion: @escaping(() -> ())) {
           
           guard let tvShow = tvShow else {
           
               return
           }
           
        TvShowDataManager.shared.saveTvShow(tvShow, completion: completion)
       }
}
