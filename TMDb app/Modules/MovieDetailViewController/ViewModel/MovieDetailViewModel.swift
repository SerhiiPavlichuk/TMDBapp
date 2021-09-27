//
//  MovieDetailViewModel.swift
//  TMDb app
//
//  Created by admin on 23.09.2021.
//

import Foundation

class MovieDetailViewModel {
    
    var movie: Movie? = nil
    var actorsArray: [Cast] = []
    var actors: Cast? 
    var video: String = String()
    
    
    func loadActors(completion: @escaping(() -> ())) {
        MovieNetworkManager.shared.requestActors(movieId: movie, completion: { actors in
            self.actorsArray = actors ?? []
            let dataArray = actors ?? []
            let actorResponce = dataArray.first

            self.actors = actorResponce
            completion()
        })
    }
    
    func loadTrailer(_ movieId: String, completion: @escaping((String) -> ())) {
            
        MovieNetworkManager.shared.requestVideos(movieId, completion: { videoKey in
            
            self.video = videoKey
            completion(videoKey)
            })
        }
    
    func saveMovieInRealm(_ movie: Movie?, completion: @escaping(() -> ())) {
        
        guard let movie = movie else {
        
            return
        }
        
        MovieDataManager.shared.saveMovie(movie, completion: completion)
    }
}










