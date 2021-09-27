//
//  MovieDataManager.swift
//  TMDb app
//
//  Created by admin on 26.09.2021.
//

import Foundation
import RealmSwift

struct MovieDataManager {
    
    let realm = try? Realm()

    static let shared = MovieDataManager()

    private init() { }
    
    func saveMovie(_ movie: Movie, completion: @escaping(() -> ())) {
        
        let movieRealm = MovieRealm()
        
        movieRealm.title = movie.title ?? ""
        movieRealm.popularity = movie.popularity ?? 0.0
        movieRealm.overview = movie.overview ?? ""
        movieRealm.id = movie.id ?? 0
        movieRealm.posterPath = movie.posterPath ?? ""

        try? realm?.write {
            realm?.add(movieRealm)
        }
        completion()
    }
    
    func getAllMovies(completion: ([Movie])->()) {
        
        var moviesRealm = [MovieRealm]()
        guard let movieResults = realm?.objects(MovieRealm.self) else { return }
        for movie in movieResults {
            moviesRealm.append(movie)
        }
        
        completion(convertToMoviesList(moviesRealm: moviesRealm))
    }
    
    private func convertToMoviesList(moviesRealm: [MovieRealm]) -> [Movie] {

        var movies = [Movie]()
        for movieRealm in moviesRealm {
            let movie = Movie(from: movieRealm)
            movies.append(movie)
        }
        return movies
    }
}
