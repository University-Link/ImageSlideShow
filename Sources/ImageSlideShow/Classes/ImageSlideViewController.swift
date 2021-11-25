//
//  ImageSlideViewController.swift
//
//  Created by Dimitri Giani on 02/11/15.
//  Copyright © 2015 Dimitri Giani. All rights reserved.
//

import UIKit

class ImageSlideViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var scrollView: UIScrollView?
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView?
	
	var slide: ImageSlideShowProtocol?
	var enableZoom = false
	
	var willBeginZoom: () -> Void = {}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if enableZoom {
			scrollView?.maximumZoomScale = 2.0
			scrollView?.minimumZoomScale = 1.0
			scrollView?.zoomScale = 1.0
		}
  
		scrollView?.isHidden = true
		loadingIndicatorView?.startAnimating()
		
		slide?.image(completion: { (image, error) -> Void in
			DispatchQueue.main.async {
				self.imageView?.image = image
				self.loadingIndicatorView?.stopAnimating()
				self.scrollView?.isHidden = false
			}
		})
  }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		if enableZoom {
			//	Reset zoom scale when the controller is hidden
			scrollView?.zoomScale = 1.0
		}
	}
	
	//	MARK: UIScrollViewDelegate
	
	func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		willBeginZoom()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		if enableZoom {
			return imageView
		}
		return nil
	}
}

extension ImageSlideViewController {
  func saveToGalleryCurrentImage() {
    guard let image = self.imageView?.image else { return }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      showAlertWith(title: "error".localized, message: error.localizedDescription)
    } else {
      showAlertWith(title: nil, message: "successSaved".localized)
    }
  }
  
  private func showAlertWith(title: String?, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(.init(title: "ok".localized, style: .default, handler: nil))
    self.present(ac, animated: true)
  }
}
