//
//  Constans.swift
//  TMDb app
//
//  Created by admin on 19.09.2021.
//

import Foundation

struct Constants {
    
    struct network {

        static let apiKey = "32ea20e318793cf10469df41ffe5990d"
        static let imagePath = "https://image.tmdb.org/t/p/original/"
        static let defaultPath = "https://api.themoviedb.org/3/"
        static let keyForVideos = "/videos?api_key=\(apiKey)&language=en-US"
        
        static let tvShowPath = defaultPath + "tv/"
        static let trendingTVShowPath = "https://api.themoviedb.org/3/trending/tv/week?api_key="
        
        static let moviePath = defaultPath + "movie/"
        static let trendingMoviePath = "https://api.themoviedb.org/3/trending/movie/week?api_key="
        
        
    }
    
    struct viewControllerTitles {
        static let media = "Media"
        static let watchLater = "Watch Later"
    }
    
    struct ui {
        static let defaultCellIdentifier = "Cell"
        static let okMessage = "Cool 👌"
        
        static let movieSavedMessage = "Movie saved in \(viewControllerTitles.watchLater) !"
        static let tvShowSavedMessage = "TV Show saved in \(viewControllerTitles.watchLater) !"
        
    }
    
}
