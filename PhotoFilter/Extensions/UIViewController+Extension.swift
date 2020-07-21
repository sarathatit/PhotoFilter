//
//  UIViewController+Extension.swift
//  PhotoFilter
//
//  Created by sarath kumar on 16/07/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
     func addChildViewController(_ childVC: UIViewController) {
        
        self.addChild(childVC)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
