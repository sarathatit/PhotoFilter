//
//  UIImageView+Extensions.swift
//  GoodCam
//
//  Created by Mohammad Azam on 1/25/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    static func imageForFilterView() -> UIImageView {
        
        let filterImageView = UIImageView(image: UIImage(named: "filter-default-image"))
        filterImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        filterImageView.layer.cornerRadius = 6.0
        filterImageView.layer.masksToBounds = true
        return filterImageView
    }
    
}
