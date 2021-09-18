//
//  MediaViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

class MediaViewController: UIViewController {
    
    
    let realm = try? Realm()
    
    @IBOutlet weak var tableView: UITableView!
    


       //MARK:- Add launchScreen animation
    
    private let imageView: UIImageView = {
           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
           imageView.image = UIImage(named: "logo")
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
    
    var tvShows: [TvShow] = []
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "TVShows"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.requestTrendingTvShows()
    }
    
    //MARK: - Methods
    
    func requestTrendingTvShows() {
        
        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=32ea20e318793cf10469df41ffe5990d"
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(PopularTvShowResult.self, from: responce.data!) {
                self.tvShows = data.tvShows ?? []
                self.tableView.reloadData()
                
            }
        }
    }
    
    
}

extension MediaViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.tvShows[indexPath.row].name
        return cell ?? UITableViewCell()
    }
}

extension MediaViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: TvShowDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? TvShowDetailViewController {
            
            detailViewController.tvShow = self.tvShows[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true )
        }
    }
}


