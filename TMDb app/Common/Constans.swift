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
        static let defaultPath = "https://api.themoviedb.org/3/"
        static let keyForVideos = "/videos?api_key=\(apiKey)&language=en-US"
        static let defaultYoutubePath = "https://www.youtube.com/watch?v="
        
        static let tvShowPath = defaultPath + "tv/"
        static let trendingTVShowPath = "https://api.themoviedb.org/3/trending/tv/week?api_key"
        
        static let moviePath = defaultPath + "movie"
        static let movieActorsPath = "/credits?api_key=\(apiKey)&language=en-US"
        static let trendingMoviePath = "https://api.themoviedb.org/3/trending/movie/week?api_key"
        static let defaultImagePath = "https://image.tmdb.org/t/p/original/"
        
    }
    
    struct viewControllerTitles {
        static let media = "Media"
        static let watchLater = "Watch Later"
    }
    
    struct ui {
        static let defaultCellIdentifier = "Cell"
        static let okMessage = "Cool 👌"
        static let imageView = "logo"
        
    
    }
    
}
