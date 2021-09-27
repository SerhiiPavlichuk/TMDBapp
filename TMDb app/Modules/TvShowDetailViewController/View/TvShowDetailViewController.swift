//
//  TvShowDetailViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper


class TvShowDetailViewController: UIViewController {
    
    var viewModel: TvShowDetailViewModel = TvShowDetailViewModel()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var tvLanguageLabel: UILabel!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        
        self.title = self.viewModel.tvShow?.name
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if let id = self.viewModel.tvShow?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        
        
        if let posterPath = self.viewModel.tvShow?.posterPath {
            let urlString = Constants.network.defaultImagePath + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        
        self.overviewLabel.text = self.viewModel.tvShow?.overview
        self.tvLanguageLabel.text = viewModel.tvShow?.originalLanguage
        self.releaseDateLabel.text = self.viewModel.tvShow?.firstAirDate
        
        if let tvShow = self.viewModel.tvShow {
            if let vote = tvShow.voteAverage {
                self.ratingLabel.text = String(describing: vote)
            }
        }
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: Constants.viewControllerTitles.watchLater, style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
        
    }
    
    func requestVideos(with movieId: String) {
        
        self.viewModel.loadTrailer(movieId) { videoKey in
            self.videoPlayerView.load(withVideoId: videoKey)
        }
    }
    private func loadByKey(_ key: String) {
        self.videoPlayerView.load(withVideoId: key)
    }
    
    
    @objc func addToWatchButtonPressed(){
        
        self.viewModel.saveTvShowInRealm(self.viewModel.tvShow, completion: {
            
            let alert = UIAlertController(title: Constants.ui.tvShowSavedAlert,
                                          message: nil,
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: Constants.ui.okMessage,
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

