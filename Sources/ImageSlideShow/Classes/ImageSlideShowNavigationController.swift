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
    let appearance = UINavigationBarAppearance()
    appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19), .foregroundColor: UIColor.white]
    appearance.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    self.navigationBar.standardAppearance = appearance
    self.navigationBar.scrollEdgeAppearance = appearance
    self.navigationBar.tintColor = .white
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
