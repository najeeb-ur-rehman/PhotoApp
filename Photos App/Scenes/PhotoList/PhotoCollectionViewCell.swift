//
//  PhotoCollectionViewCell.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
	// MARK: Outlets
	@IBOutlet weak var outerView: UIView!
	@IBOutlet weak var imageView: UIImageView!
	
	
	// MARK: Data Populate Methods
	func setPhoto(_ photo: Photo) {
		imageView.sd_setImage(with: photo.url,
							  placeholderImage: UIImage(named: "placeholder"),
							  options: .continueInBackground) { (_, _, _, _) in
		}
	}
}
