//
//  WatchLaterViewModel.swift
//  TMDb app
//
//  Created by admin on 27.09.2021.
//

import Foundation
import RealmSwift

class WatchLaterViewModel {
    
    let realm = try? Realm()
    var tvShows: [TvShowRealm] = []
    var movies: [MovieRealm] = []
    
    
    func getTvShow() -> [TvShowRealm] {
        
        var tvShow = [TvShowRealm]()
        guard let tvShowResult = realm?.objects(TvShowRealm.self) else { return [] }
        for tvshow in tvShowResult {
            tvShow.append(tvshow)
        }
        return tvShow
    }
    func getMovie() -> [MovieRealm] {
          
          var movies = [MovieRealm]()
          guard let movieResult = realm?.objects(MovieRealm.self) else { return [] }
          for movie in movieResult {
            movies.append(movie)
          }
          return movies
      }
}
