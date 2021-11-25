Pod::Spec.new do |s|
  s.name         = "ImageSlideShowSwift"
  s.version      = "0.1.8"
  s.summary      = "A simple Swift 5 Slideshow for iOS"
  s.description  = "ImageSlideShow is a simple Slideshow for images (Picture, Photos) for your apps written in Swift 5."
  s.homepage     = "https://github.com/dimix/ImageSlideShow"
  s.screenshots  = "https://raw.githubusercontent.com/dimix/ImageSlideShow/master/demo.gif"
  s.license      = "MIT"
  s.author       = { "Dimitri Giani" => "dimitri.giani@gmail.com" }
  s.platform     = :ios, "13.0"
  s.ios.deployment_target = "13.4"
  s.source       = { :git => "https://github.com/dimix/ImageSlideShow.git", :tag => "#{s.version}" }
  s.source_files = "Classes", "Sources/ImageSlideShow/**/**/*.{swift}"
  s.resources    = "Sources/ImageSlideShow/Storyboard/*.{png,jpeg,jpg,storyboard,xib}"
  s.framework    = "UIKit"
end
