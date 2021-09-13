//
//  WatchTvShowLaterViewController.swift
//  TMDb app
//
//  Created by admin on 03.08.2021.
//

import UIKit
import RealmSwift

class WatchTvShowLaterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let realm = try? Realm()
    var tvShows: [TvShowRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tvShows = self.getTvShows()
        self.tableView.reloadData()
    }
    
    func getTvShows() -> [TvShowRealm] {
        
        var tvShows = [TvShowRealm]()
        guard let tvShowResult = realm?.objects(TvShowRealm.self) else { return [] }
        for tvShow in tvShowResult {
            tvShows.append(tvShow)
        }
        return tvShows
    }
    
}

extension WatchTvShowLaterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.tvShows[indexPath.row].name
        
        return cell ?? UITableViewCell()
    }
    
    
}

