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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        if editingStyle == .delete {
            switch selectedIndex {
            case 0:
                let item = viewModel.movies[indexPath.row]
                tableView.beginUpdates()
                viewModel.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                try! viewModel.realm?.write {
                    viewModel.realm?.delete(item)
                }
                
            case 1:
                
                let item = viewModel.tvShows[indexPath.row]
                tableView.beginUpdates()
                viewModel.tvShows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                try! viewModel.realm?.write {
                    viewModel.realm?.delete(item)
                }
                
            default: break
            }
        }
    }
}


//extension WatchLaterViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//}


