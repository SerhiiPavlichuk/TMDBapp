//
//  ViewController.swift
//  TMDb app
//
//  Created by admin on 01.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try? Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    var tvShows: [TvShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "TVShows"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.requestTrendingTvShows()
    }
    
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

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.tvShows[indexPath.row].name
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: TvShowDetailViewController.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(identifier: identifier) as? TvShowDetailViewController {
            
            detailViewController.tvShow = self.tvShows[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true )
        }
    }
}


