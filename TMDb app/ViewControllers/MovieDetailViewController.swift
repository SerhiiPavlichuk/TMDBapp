//
//  MovieDetailViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//


import UIKit
import SDWebImage
import RealmSwift

class MovieDetailViewController: UIViewController {
    
    let realm = try? Realm()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var movie: Movie? = nil
    
    let baseImageURL = "https://image.tmdb.org/t/p/original/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.movie?.title
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.detailLabel.text = self.movie?.overview
        
        if let posterPath = self.movie?.posterPath {
            let urlString = self.baseImageURL + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: "Watch Later", style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
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

