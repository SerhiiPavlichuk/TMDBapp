//
//  MovieDetailViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Alamofire
import youtube_ios_player_helper


class MovieDetailViewController: UIViewController {
    
    let realm = try? Realm()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var tvLanguageLabel: UILabel!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    
    var movie: Movie? = nil
    
    let imageUrlFirstPart = "https://image.tmdb.org/t/p/original/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.movie?.title
        self.navigationController?.navigationBar.prefersLargeTitles = false
     
        
        if let posterPath = self.movie?.posterPath {
            let urlString = self.imageUrlFirstPart + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        
   
        
        if let id = self.movie?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        
     
        
        self.overviewLabel.text = self.movie?.overview
        self.tvLanguageLabel.text = movie?.originalLanguage
        self.releaseDateLabel.text = self.movie?.releaseDate
        
        if let movie = self.movie {
            if let vote = movie.voteAverage {
                self.ratingLabel.text = String(describing: vote)
            }
        }
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: "Watch Later", style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
    }
    
    
    
    func requestVideos(with id: String) {
        
        let url = "\(Constants.network.moviePath)\(id)\(Constants.network.keyForVideos)"
        
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            guard let data = responce.data else { return }
            
            if let data = try? decoder.decode(Trailers.self, from: data) {
                guard let id = data.results?.first?.key else { return }
                self.videoPlayerView.load(withVideoId: id)
            }
        }
    }
    
    
    @objc func addToWatchButtonPressed(){
        
        let movieRealm = MovieRealm()
        movieRealm.title = self.movie?.title ?? ""
        movieRealm.popularity = self.movie?.popularity ?? 0.0
        movieRealm.overview = self.movie?.overview ?? ""
        movieRealm.id = self.movie?.id ?? 0
        movieRealm.backdropPath = self.movie?.backdropPath ?? ""
        movieRealm.mediaType = self.movie?.mediaType ?? ""
        movieRealm.posterPath = self.movie?.posterPath ?? ""
        
        try? realm?.write {
            realm?.add(movieRealm)
        }
    }
}

