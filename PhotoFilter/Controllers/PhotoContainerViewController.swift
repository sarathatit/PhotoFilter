//
//  PhotoContainerViewController.swift
//  PhotoFilter
//
//  Created by sarath kumar on 15/07/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//
import Foundation
import UIKit

class PhotoContainerViewController: UIViewController,PhotoCollectionViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PhotoFilterViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let photoCVC = self.children.first as? PhotosCollectionViewController  else {
            return
        }
        
        photoCVC.delegate = self
    }
    
    // MARK:- Custom Method
    
    func photoFilterCancel() {
        showPhotosList()
    }
    
    func photoFilterDone() {
         showPhotosList()
    }
    
    private func showPhotosList() {
          
          self.view.subviews.forEach {
              $0.removeFromSuperview()
          }
          
          guard let photoCVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotosCollectionViewController") as? PhotosCollectionViewController else {
              fatalError("PhotosCollectionViewController does not exist")
          }
          
          photoCVC.delegate = self
          self.addChildViewController(photoCVC)
          
      }

    func selectedImage(image: UIImage) {
       // showImagePreview(image)
        showFilterViewController(originalImage: image)
    }
    
    private func showImagePreview(_ previewImage: UIImage) {
        guard let imagePrviewVC = self.storyboard?.instantiateViewController(identifier: "ImagePreviewViewController") as? ImagePreviewViewController else {
            fatalError("ImagePreviewViewController not found")
        }
        imagePrviewVC.selectedImage = previewImage
        self.navigationController?.pushViewController(imagePrviewVC, animated: true)
    }
    
    private func showFilterViewController(originalImage: UIImage) {
        
        guard let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else {
            fatalError("FilterViewController not found!!")
        }
        filterVC.image = originalImage
        self.addChildViewController(filterVC)
    }
    
    //MARK:- Button Action Methods
    @IBAction func cameraButtonAction(_ sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true, completion: nil)
        }
    }

    //MARK:- Camera Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showFilterViewController(originalImage: originalImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
