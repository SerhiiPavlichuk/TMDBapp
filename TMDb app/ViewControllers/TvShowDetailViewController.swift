//
//  TvShowDetailViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Alamofire


class TvShowDetailViewController: UIViewController {
    
    let realm = try? Realm()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tvShowLanguage: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var tvShow: TvShow? = nil
    
    let imageUrlFirstPart = "https://image.tmdb.org/t/p/original/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.tvShow?.name
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if let id = self.tvShow?.id{
            let stringId = String (describing: id)
            self.requestTrailerVideo(with: stringId)
        }
        
        if let posterPath = self.tvShow?.posterPath {
            let urlString = self.imageUrlFirstPart + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        
        if let voteAvarage = self.tvShow?.voteAverage {
            let someString: String = String(voteAvarage)
            self.ratingLabel.text = "Vote Average: " + someString
        }
        
        if let tvShowLanguage = self.tvShow?.originalLanguage {
            let someStringForLanguage: String = String(tvShowLanguage)
            self.tvShowLanguage.text = "Language: " + someStringForLanguage
        }
        
        if let releaseDateLabel = self.tvShow?.firstAirDate {
            let stringFOrReleaseDateLabel: String = String(releaseDateLabel)
            self.releaseDateLabel.text = "Release Date: " + stringFOrReleaseDateLabel
        }
        
        if let overviewLabel = self.tvShow?.overview {
            let stringFOrOverview: String = String(overviewLabel)
            self.overviewLabel.text = "Overview: " + stringFOrOverview
        }
        
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: "Watch Later", style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
    }
    func requestTrailerVideo(with id: String) {
        let url =    "https://api.themoviedb.org/3/tv/\(self.tvShow?.id)/videos?api_key=32ea20e318793cf10469df41ffe5990d&language=en-US"
        AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(PopularTvShowResult.self, from: responce.data!) {
//                    self.tvShows = data.tvShows ?? []
//                    self.tableView.reloadData()
                }
        }
    }
    
    @objc func addToWatchButtonPressed(){
        
        let tvShowRealm = TvShowRealm()
        tvShowRealm.name = self.tvShow?.name ?? ""
        tvShowRealm.popularity = self.tvShow?.popularity ?? 0.0
        tvShowRealm.overview = self.tvShow?.overview ?? ""
        tvShowRealm.id = self.tvShow?.id ?? 0
        tvShowRealm.backdropPath = self.tvShow?.backdropPath ?? ""
        tvShowRealm.mediaType = self.tvShow?.mediaType ?? ""
        tvShowRealm.posterPath = self.tvShow?.posterPath ?? ""
        
        try? realm?.write {
            realm?.add(tvShowRealm)
        }
    }
}

