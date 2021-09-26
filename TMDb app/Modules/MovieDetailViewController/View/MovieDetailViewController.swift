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
import SafariServices


class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    let realm = try? Realm()
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
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
        self.releaseDateLabel.text = self.viewModel.movie?.releaseDate
        
        if let movie = self.viewModel.movie {
            if let vote = movie.voteAverage {
                self.ratingLabel.text = String(describing: vote)
            }
        }
        let addToWatchLaterBarButtonItem = UIBarButtonItem(title: "Watch Later", style: .done, target: self, action: #selector(addToWatchButtonPressed))
        self.navigationItem.rightBarButtonItem = addToWatchLaterBarButtonItem
        
        
    }

    
    @IBAction func trailerButtonPressed(_ sender: Any) {
        
        let url = URL(string: Constants.network.defaultYoutubePath + viewModel.video)!
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    @objc func addToWatchButtonPressed(){
        
        let movieRealm = MovieRealm()
        movieRealm.title = self.viewModel.movie?.title ?? ""
        movieRealm.popularity = self.viewModel.movie?.popularity ?? 0.0
        movieRealm.overview = self.viewModel.movie?.overview ?? ""
        movieRealm.id = self.viewModel.movie?.id ?? 0
        movieRealm.backdropPath = self.viewModel.movie?.backdropPath ?? ""
        movieRealm.mediaType = self.viewModel.movie?.mediaType ?? ""
        movieRealm.posterPath = self.viewModel.movie?.posterPath ?? ""
        
        try? realm?.write {
            realm?.add(movieRealm)
        }
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
        cell.configureWith(actorName: currentActor.name, profilePath: currentActor.profile_path)
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
