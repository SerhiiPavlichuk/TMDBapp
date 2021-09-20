//
//  TVShowTableViewCell.swift
//  TMDb app
//
//  Created by admin on 19.09.2021.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tvShowNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.repositoryView.layer.cornerRadius = 24
    }
    
    private func setupUI() {
        self.tvShowNameLabel.textColor = .white
        self.descriptionLabel.textColor = .white
        self.selectionStyle = .none
    }
    
    
    func tvShowConfigureWith(imageURL: URL?, tvShowName: String?, description: String?) {
        self.tvShowNameLabel.text = tvShowName
        self.descriptionLabel.text = description
        self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        self.setupUI()
    }
    
}
