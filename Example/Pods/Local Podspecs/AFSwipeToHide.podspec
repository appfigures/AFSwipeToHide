#
# Be sure to run `pod lib lint AFSwipeToHide.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AFSwipeToHide"
  s.version          = "0.1.0"
  s.summary          = "Hide your toolbars with a swipe. Just like Safari for iOS."
  s.description      = <<-DESC
                        A simple utility class to help achieve Safari's swipe-to-hide effect.
                        The class can be used as a UIScrollViewDelegate or on its own. Check out
                        the example project for simple usage.
                       DESC
  s.homepage         = "https://github.com/appFigures/AFSwipeToHide"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Oz" => "oz" }
  s.source           = { :git => "https://github.com/appFigures/AFSwipeToHide.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/appFigures'

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
