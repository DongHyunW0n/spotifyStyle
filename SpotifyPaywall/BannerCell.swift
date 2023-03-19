//
//  BannerCell.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var titletext: UILabel!
    
    @IBOutlet weak var descriptLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
    }
    
    func configure(_ info: BannerInfo){
        
        titletext.text = info.title
        descriptLabel.text = info.description
        imageView.image = UIImage(named: info.imageName)
        
    }
    
}
