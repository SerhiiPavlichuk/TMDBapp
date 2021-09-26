//
//  MovieTableViewCell.swift
//  TMDb app
//
//  Created by admin on 19.09.2021.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.repositoryView.layer.cornerRadius = 24
    }
    
    private func setupUI() {
        self.movieNameLabel.textColor = .white
        self.descriptionLabel.textColor = .white
        self.selectionStyle = .none
    }
    
    
    func movieConfigureWith(imageURL: URL?, movieName: String?, description: String?) {
        self.movieNameLabel.text = movieName
        self.descriptionLabel.text = description
        self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        self.setupUI()
    }
}
