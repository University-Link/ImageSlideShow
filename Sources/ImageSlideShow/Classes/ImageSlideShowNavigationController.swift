//
//  ImageSlideShowNavigationController.swift
//
//  Created by Dimitri Giani on 27/10/2016.
//  Copyright © 2016 Dimitri Giani. All rights reserved.
//

import UIKit

class ImageSlideShowNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationBar.tintColor = .white
    self.navigationBar.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.isTranslucent = true
    self.view.backgroundColor = .black
  }
  
  override var childForStatusBarStyle: UIViewController? {
		return topViewController
	}
	
	override var prefersStatusBarHidden: Bool {
		if let prefersStatusBarHidden = viewControllers.last?.prefersStatusBarHidden {
			return prefersStatusBarHidden
		}
		return false
	}
}
