//
//  WatchLaterViewController.swift
//  TMDb app
//
//  Created by admin on 27.09.2021.
//

import Foundation
import RealmSwift

class WatchLaterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    var viewModel: WatchLaterViewModel = WatchLaterViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.viewControllerTitles.watchLater
        
        let tvTableViewCellIdentifier = String(describing: TVShowTableViewCell.self)
        self.tableView.register(UINib(nibName: tvTableViewCellIdentifier, bundle: nil),
                                forCellReuseIdentifier: tvTableViewCellIdentifier)

        let movieTableViewCellIdentifier = String(describing: MovieTableViewCell.self)
        self.tableView.register(UINib(nibName: movieTableViewCellIdentifier, bundle: nil),
                                forCellReuseIdentifier: movieTableViewCellIdentifier)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ui.defaultCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.tvShows = self.viewModel.getTvShow()
        self.viewModel.movies = self.viewModel.getMovie()
        self.tableView.reloadData()
        
    }
}

extension WatchLaterViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 500
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        switch selectedIndex
        {
        case 0:
            return self.viewModel.movies.count
        case 1:
            return self.viewModel.tvShows.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            
            let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.ui.movieCellIdentifier, for: indexPath) as? MovieTableViewCell
            
            let movieMedia = self.viewModel.movies[indexPath.row]
            let movieImagePathString = Constants.network.defaultImagePath + movieMedia.posterPath
            movieCell?.movieConfigureWith(imageURL: URL(string: movieImagePathString),
                                          movieName: movieMedia.title,
                                            description: movieMedia.overview)
            
            return movieCell ?? UITableViewCell()
            
        case 1:
            
            let tvShowCell = tableView.dequeueReusableCell(withIdentifier: Constants.ui.tvShowCellIdentifier, for: indexPath) as? TVShowTableViewCell
            
            let tvShowMedia = self.viewModel.tvShows[indexPath.row]
            let tvShowImagePathString = Constants.network.defaultImagePath + tvShowMedia.posterPath
            tvShowCell?.tvShowConfigureWith(imageURL: URL(string: tvShowImagePathString),
                                            tvShowName: tvShowMedia.name,
                                            description: tvShowMedia.overview)
            
            return tvShowCell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
        
    }
    @IBAction func mediaSegmentedControlChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
//    //MARK: - Delete Function
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        let selectedIndex = self.TMWLSegmentedControl.selectedSegmentIndex
//        if editingStyle == .delete {
//            switch selectedIndex {
//            case 0:
//                self.deleteTVShows(objectID: self.tvShows[indexPath.row].id ?? 0)
//                self.tvShows = self.getTVShows()
//            case 1:
//                self.deleteMovie(objectID: self.movies[indexPath.row].id ?? 0)
//                self.movies = self.getMovies()
//            default: break
//            }
//
//        }
//        // fix in another way
//        tableView.reloadData()
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//
//    func deleteTVShows(objectID: Int) {
//        let object = realm?.objects(TVShowsRealm.self).filter("id = %@", objectID).first
//        try! realm!.write {
//            realm?.delete(object!)
//        }
//    }
//
//    func deleteMovie(objectID: Int) {
//        let object = realm?.objects(MoviesRealm.self).filter("id = %@", objectID).first
//        try! realm!.write {
//            realm?.delete(object!)
//        }
//    }
//}
//
//
//extension WatchLaterViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 540
//    }
//
//    //Appearing cells animation
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.75) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let selectedIndex = self.TMWLSegmentedControl.selectedSegmentIndex
//        // move to router
//        switch selectedIndex
//        {
//        case 0:
//            let tvIdentifier = String(describing: TVShowDetailsViewController.self)
//            if let detailViewController = storyboard.instantiateViewController(identifier: tvIdentifier) as? TVShowDetailsViewController {
//                detailViewController.tvShow = self.tvShows[indexPath.row]
//                self.navigationController?.pushViewController(detailViewController, animated: true)
//            }
//        case 1:
//            let movieIdentifier = String(describing: MovieDetailsViewController.self)
//            if let detailViewController = storyboard.instantiateViewController(identifier: movieIdentifier) as? MovieDetailsViewController {
//                detailViewController.movie = self.movies[indexPath.row]
//                self.navigationController?.pushViewController(detailViewController, animated: true)
//            }
//        default:
//            return
//        }
//    }
//}
}

