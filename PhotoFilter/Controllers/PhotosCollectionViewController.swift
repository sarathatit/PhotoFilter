//
//  PhotosCollectionViewController.swift
//  PhotoFilter
//
//  Created by sarath kumar on 15/07/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import UIKit
import Photos

protocol PhotoCollectionViewControllerDelegate {
    func selectedImage(image: UIImage)
}

private let reuseIdentifier = "cell"

class PhotosCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()
    var delegate: PhotoCollectionViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPhotos()
    }
    
    // MARK:- Custom Methods
    
    func loadPhotos() {
        
        requestPermission { [weak self] status in
            if status == .authorized {
                
                let asset = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                asset.enumerateObjects { (objects, count, stop) in
                    self?.images.append(objects)
                }
                self?.images.reverse()
                self?.collectionView.reloadData()
            }
        }
    }
    
    func requestPermission(completion: @escaping (PHAuthorizationStatus) -> ()) {
        
        PHPhotoLibrary.requestAuthorization() { status in
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
    //MARK:- CollectionView Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell not found")
        }
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (image, _) in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    //MARK:- CollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 320, height: 480), contentMode: .aspectFill, options: options) { (image, _) in
            if let image = image {
                self.delegate?.selectedImage(image: image)
            }
        }
    }
}
