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
import youtube_ios_player_helper


class TvShowDetailViewController: UIViewController {
    
    let realm = try? Realm()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var tvLanguageLabel: UILabel!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    
    var tvShow: TvShow? = nil
    
    let imageUrlFirstPart = "https://image.tmdb.org/t/p/original/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = self.tvShow?.name
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if let id = self.tvShow?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        
        if let posterPath = self.tvShow?.posterPath {
            let urlString = self.imageUrlFirstPart + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
    
        self.overviewLabel.text = self.tvShow?.overview
        self.tvLanguageLabel.text = tvShow?.originalLanguage
        self.releaseDateLabel.text = self.tvShow?.firstAirDate
        
        if let tvShow = self.tvShow {
            if let vote = tvShow.voteAverage {
                self.ratingLabel.text = String(describing: vote)
            }
        }
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: "Watch Later", style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
    }
    
  
    
    func requestVideos(with id: String) {
        
        let url = "\(Constants.network.tvShowPath)\(id)\(Constants.network.keyForVideos)"
        
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

