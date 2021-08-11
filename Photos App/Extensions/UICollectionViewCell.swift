//
//  UICollectionViewCell.swift
//  Photos App
//
//  Created by Najeeb VenD on 11/08/2021.
//

import UIKit

extension UICollectionViewCell {
	
	static var reuseIdentifier: String {
		return String(describing: self)
	}
	
}
