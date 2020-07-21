//
//  ImagePreviewViewController.swift
//  PhotoFilter
//
//  Created by sarath kumar on 16/07/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    @IBOutlet weak var previewImage: UIImageView!
    
    var selectedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.previewImage.image = selectedImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
