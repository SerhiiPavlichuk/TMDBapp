//
//  MediaViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit

class MediaViewController: UIViewController {
    
    var viewModel: MediaViewModel = MediaViewModel()
    
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        self.setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.viewModel.loadMovies(completion: {
            self.tableView.reloadData()
        })
        
        self.viewModel.loadTvShows(completion: {
                   self.tableView.reloadData()
               })
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
       
    }
    
    
    //MARK:- Add launchScreen animation
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        imageView.image = UIImage(named: Constants.ui.imageView)
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        launchScreenAnimate()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
            self.launchScreenAnimate()
        })
    }
    
    private func launchScreenAnimate() {
        UIView.animate(withDuration: 0.8, animations: {
            let size = self.view.frame.size.width * 20
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
            
            self.imageView.alpha = 0
        })
    }
    
    func setupUI() {
        
        let movieTableViewCellIdentifier = String(describing: MovieTableViewCell.self)
        self.tableView.register(UINib(nibName: movieTableViewCellIdentifier, bundle: nil),
                                forCellReuseIdentifier: movieTableViewCellIdentifier)
        
        let tvTableViewCellIdentifier = String(describing: TVShowTableViewCell.self)
        self.tableView.register(UINib(nibName: tvTableViewCellIdentifier, bundle: nil),
                                forCellReuseIdentifier: tvTableViewCellIdentifier)
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ui.defaultCellIdentifier)
        
        
        self.title = Constants.viewControllerTitles.media
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
}

extension MediaViewController: UITableViewDataSource{
    
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        switch selectedIndex {
        
        case 0:
            
            let cellIdentifier = String(describing: MovieTableViewCell.self)
            let movieCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
            
            let movieMedia = self.viewModel.movies[indexPath.row]
            
            if let imagePath = movieMedia.posterPath {
                let movieImageUrl = Constants.network.defaultImagePath + imagePath
                movieCell.movieConfigureWith(imageURL: URL(string: movieImageUrl),
                                             movieName: movieMedia.originalTitle, description: movieMedia.overview )
            }
            
            return movieCell
            
        case 1:
            
            let cellIdentifier = String(describing: TVShowTableViewCell.self)
            let tvShowCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TVShowTableViewCell
            
            let tvShowMedia = self.viewModel.tvShows[indexPath.row]
            if let imagePath = tvShowMedia.posterPath {
                let tvShowImageUrl = Constants.network.defaultImagePath + imagePath
                tvShowCell.tvShowConfigureWith(imageURL: URL(string: tvShowImageUrl),
                                               tvShowName: tvShowMedia.originalName, description: tvShowMedia.overview)
                
            }
            return tvShowCell
        default:
            return UITableViewCell()
        }
    }
    @IBAction func mediaSegmentedChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

extension MediaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            
            let movieIdentifier = String(describing: MovieDetailViewController.self)
            
            if let detailViewController = storyboard.instantiateViewController(identifier: movieIdentifier) as? MovieDetailViewController {
                detailViewController.viewModel.movie = self.viewModel.movies[indexPath.row]
                
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            
        case 1:
            
            let tvShowIdentifier = String(describing: TvShowDetailViewController.self)
            
            if let detailViewController = storyboard.instantiateViewController(identifier: tvShowIdentifier) as? TvShowDetailViewController {
                detailViewController.tvShow = self.viewModel.tvShows[indexPath.row]
                
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectedIndex = self.mediaSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            
            let movieIdentifier = String(describing: MovieDetailViewController.self)
            
            if storyboard.instantiateViewController(identifier: movieIdentifier) is MovieDetailViewController {
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, +500, 50, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0.5
                
            }
            
        case 1:
            
            let TvIdentifier = String(describing: TvShowDetailViewController.self)
            
            if storyboard.instantiateViewController(identifier: TvIdentifier) is TvShowDetailViewController {
                
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 50, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0.5
                
                
            }
            
        default:
            let movieIdentifier = String(describing: MovieDetailViewController.self)
            
            if storyboard.instantiateViewController(identifier: movieIdentifier) is MovieDetailViewController {
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, +500, 50, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0.5
                
                
            }
        }
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}
