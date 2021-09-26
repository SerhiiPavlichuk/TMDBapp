//
//  MediaViewModel.swift
//  TMDb app
//
//  Created by admin on 23.09.2021.
//

import Foundation

class MediaViewModel {
    
    var tvShows: [TvShow] = []
    var movies: [Movie] = []
    
    func loadMovies(completion: @escaping(() -> ())) {
        MovieNetworkManager.shared.requestTrendingMovies(completion: { movies in
            self.movies = movies
            completion()
        })
    }
    
    func loadTvShows(completion: @escaping(() -> ())) {
          TvShowNetworkManager.shared.requestTrendingTvShows(completion: { tvShows in
              self.tvShows = tvShows
              completion()
          })
      }
}
