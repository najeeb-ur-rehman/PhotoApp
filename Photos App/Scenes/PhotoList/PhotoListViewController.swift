//
//  PhotoListViewController.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import UIKit

protocol PhotoListDisplayLogic: class {
	func displayPhotos(_ photos: [Photo])
	func displayError(_ error: String)
}

class PhotoListViewController: UIViewController {
	
	// MARK: Outlets
	@IBOutlet var photoListView: PhotoListView!
	
	
	// MARK: Properties
	var interactor: PhotoListBusinessLogic?
	private var photos = [Photo]()
	
	private var collectionViewLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.sectionInset = .zero
		return layout
	}()
	
	
	// MARK: UIViewController Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		updateCollectionViewLayoutForScrollDirection(.vertical, andIndexPath: IndexPath(row: 0, section: 0))
		interactor?.fetchPhotosPage()
	}
	
	// MARK: Setup Methods
	private func setupCollectionView() {
		photoListView.collectionview.collectionViewLayout = collectionViewLayout
		photoListView.collectionview.dataSource = self
		photoListView.collectionview.delegate = self
	}
	
	private func updateCollectionViewLayoutForScrollDirection(_ scrollDirection: UICollectionView.ScrollDirection, andIndexPath indexPath: IndexPath) {
		collectionViewLayout.scrollDirection = scrollDirection
		switch scrollDirection {
		case .horizontal:
			photoListView.backButton.isHidden = false
			photoListView.backButton.tintColor = UIColor(hexString: photos[indexPath.row].color).inverted
			let width = photoListView.frame.width
			let height = photoListView.collectionview.frame.height - (photoListView.collectionview.adjustedContentInset.top + photoListView.collectionview.adjustedContentInset.bottom)
			collectionViewLayout.itemSize = CGSize(width: width, height: height)
			photoListView.collectionview.isPagingEnabled = false
			photoListView.collectionview.reloadData()
			photoListView.collectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
			photoListView.collectionview.isPagingEnabled = true
			
		default:
			photoListView.backButton.isHidden = true
			let length = photoListView.frame.width / 2
			collectionViewLayout.itemSize = CGSize(width: length, height: length)
			photoListView.collectionview.isPagingEnabled = false
			photoListView.collectionview.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
			photoListView.collectionview.reloadData()
		}
	}
	
	// MARK: Actions
	@IBAction
	func backButtonAction(_ sender: UIButton) {
		let offSet = photoListView.collectionview.contentOffset.x
		let width = photoListView.collectionview.frame.width
		let horizontalCenter = width / 2
		let page = Int(offSet + horizontalCenter) / Int(width)
		let indexPath = IndexPath(row: page, section: 0)
		updateCollectionViewLayoutForScrollDirection(.vertical, andIndexPath: indexPath)
	}
}


// MARK: - UICollectionview DataSource Methods
extension PhotoListViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
													  for: indexPath) as! PhotoCollectionViewCell
		cell.setPhoto(photos[indexPath.row])
		return cell
	}
	
}


// MARK: - UIScrollView Methods
extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let actualPosition = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height - scrollView.frame.size.height
		if contentHeight > 0 && contentHeight - actualPosition <= 20 {
			interactor?.fetchPhotosPage()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		updateCollectionViewLayoutForScrollDirection(.horizontal, andIndexPath: indexPath)
		collectionView.reloadData()
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
}

// MARK: - Display Logic Methods
extension PhotoListViewController: PhotoListDisplayLogic {
	
	func displayError(_ error: String) {
		Utils.onMainThread {
			Utils.showErrorAlert(message: error, viewController: self)
		}
	}
	
	func displayPhotos(_ photos: [Photo]) {
		self.photos.append(contentsOf: photos)
		Utils.onMainThread {
			self.photoListView.collectionview.reloadData()
		}
	}
	
}
