//
//  WatchMovieLaterViewController.swift
//  TMDb app
//
//  Created by admin on 03.08.2021.
//

import UIKit
import RealmSwift

class WatchMovieLaterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try? Realm()
    var movies: [MovieRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movies = self.getMovies()
        self.tableView.reloadData()
    }
    
    func getMovies() -> [MovieRealm] {
        
        var movies = [MovieRealm]()
        guard let moviesResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in moviesResult {
            movies.append(movie)
        }
        return movies
    }
    
}

extension WatchMovieLaterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.movies[indexPath.row].title
        
        return cell ?? UITableViewCell()
    }
    
    
}
