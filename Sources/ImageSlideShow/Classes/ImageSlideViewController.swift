//
//  ImageSlideViewController.swift
//
//  Created by Dimitri Giani on 02/11/15.
//  Copyright © 2015 Dimitri Giani. All rights reserved.
//

import UIKit
import Photos

class ImageSlideViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var scrollView: UIScrollView?
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView?
	
  private let maximumZoomScale: CGFloat = 2.0
  private let minimumZoomScale: CGFloat = 1.0
	var slide: ImageSlideShowProtocol?
	var enableZoom = false
	var willBeginZoom: () -> Void = {}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
    if self.enableZoom {
      self.scrollView?.maximumZoomScale = self.maximumZoomScale
      self.scrollView?.minimumZoomScale = self.minimumZoomScale
      self.scrollView?.zoomScale = 1.0
		}
    self.scrollView?.contentInsetAdjustmentBehavior = .never
    self.scrollView?.isHidden = true
    self.loadingIndicatorView?.startAnimating()
		
    self.slide?.image(completion: { (image, error) -> Void in
			DispatchQueue.main.async {
				self.imageView?.image = image
				self.loadingIndicatorView?.stopAnimating()
				self.scrollView?.isHidden = false
			}
		})
  }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
    if self.enableZoom {
			//	Reset zoom scale when the controller is hidden
      self.scrollView?.zoomScale = 1.0
		}
	}
	
	//	MARK: UIScrollViewDelegate
	
	func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    self.willBeginZoom()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    if self.enableZoom {
      return self.imageView
		}
		return nil
	}
}

// MARK: Gesture

extension ImageSlideViewController {
  public func onDoubleTap() {
    guard let scrollView = self.scrollView else { return }
    if scrollView.zoomScale > scrollView.minimumZoomScale {
      scrollView.setZoomScale(self.minimumZoomScale, animated: true)
    } else {
      scrollView.setZoomScale(self.maximumZoomScale, animated: true)
    }
  }
}

// MARK: Save Image

extension ImageSlideViewController {
  func saveToGalleryCurrentImage() {
    guard let image = self.imageView?.image else { return }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      let status = PHPhotoLibrary.authorizationStatus()
      if status == .denied {
        let message = "이미지를 앨범에 저장할 수 있도록 설정에서 허용해주세요."
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "ok".localized, style: .default, handler: { _ in
          self.goToSettings()
        }))
        alert.addAction(.init(title: "cancel".localized, style: .cancel))
        self.present(alert, animated: true)
      } else {
        showAlertWith(title: "error".localized, message: error.localizedDescription)
      }
    } else {
      showAlertWith(title: "", message: "successSaved".localized)
    }
  }
  
  private func showAlertWith(title: String? = nil, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(.init(title: "ok".localized, style: .default, handler: nil))
    self.present(ac, animated: true)
  }
  
  func goToSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:])
    }
  }
}
