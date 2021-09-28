//
//  MovieDetailViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import SDWebImage
import SafariServices
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewUI()
        setupUI()
        
        if let id = self.viewModel.movie?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
          
        }
    }
    
    func setupCollectionViewUI(){
        
        let actorsCollectionViewCellIdentifier = String(describing: ActorsCollectionViewCell.self)
        
        self.collectionView.register(UINib(nibName: actorsCollectionViewCellIdentifier, bundle: nil),
                                     forCellWithReuseIdentifier: actorsCollectionViewCellIdentifier)
        
        self.viewModel.loadActors(completion: {
            self.collectionView.reloadData()
        })
    }

    func requestVideos(with movieId: String) {

           self.viewModel.loadTrailer(movieId) { videoKey in
               self.videoPlayerView.load(withVideoId: videoKey)
           }
       }
    
    func setupUI() {
        
        self.title = self.viewModel.movie?.title
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if let posterPath = self.viewModel.movie?.posterPath {
            let urlString = Constants.network.defaultImagePath + posterPath
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        }
        self.overviewLabel.text = self.viewModel.movie?.overview
//        self.releaseDateLabel.text = self.viewModel.movie?.releaseDate
        
        if let movie = self.viewModel.movie {
            if let vote = movie.voteAverage {
//                self.ratingLabel.text = String(describing: vote)
            }
        }
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: Constants.viewControllerTitles.watchLater, style: .done, target: self, action: #selector(addToWatchLaterButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
        
        
    }
    private func loadByKey(_ key: String) {
           self.videoPlayerView.load(withVideoId: key)
       }

//    @IBAction func trailerButtonPressed(_ sender: Any) {
//
//        let url = URL(string: Constants.network.defaultYoutubePath + viewModel.video)!
//        let config = SFSafariViewController.Configuration()
//        config.entersReaderIfAvailable = true
//
//        let vc = SFSafariViewController(url: url, configuration: config)
//        present(vc, animated: true)
//    }
    
    @objc func addToWatchLaterButtonPressed(){

        self.viewModel.saveMovieInRealm(self.viewModel.movie, completion: {

            let alert = UIAlertController(title: Constants.ui.movieSavedAlert,
                                          message: nil,
                                          preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: Constants.ui.okMessage,
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.actorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = String(describing: ActorsCollectionViewCell.self)
        
        let currentActor = self.viewModel.actorsArray[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? ActorsCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        cell.configureWith(actorName: currentActor.name, profilePath: currentActor.profilePath)
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
