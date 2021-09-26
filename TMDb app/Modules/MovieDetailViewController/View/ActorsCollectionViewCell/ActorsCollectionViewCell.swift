//
//  ActorsCollectionViewCell.swift
//  TMDb app
//
//  Created by admin on 23.09.2021.
//

import UIKit
import SDWebImage

class ActorsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCell()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cellImageView.layer.cornerRadius = 16
    }
    
    func configureWith(actorName: String?, profilePath: String?) {
        self.cellTitleLabel.text = actorName
        self.loadImage(profilePath: profilePath)
        self.setupCell()
    }
    private func setupCell() {
        self.cellImageView.contentMode = .scaleAspectFill
    }
    
    private func loadImage(profilePath: String?) {
        
        guard let profilePath = profilePath else {
            return
        }
        let imageURL = URL(string: Constants.network.defaultImagePath + profilePath)
        self.cellImageView.sd_setImage(with: imageURL, completed: nil)
    }
    
}
