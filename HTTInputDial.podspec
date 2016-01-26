#
# Be sure to run `pod lib lint HTTInputDial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HTTInputDial"
  s.version          = "0.1.2"
  s.summary          = "Circular input dial for iPhone apps."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
A circular input dial for iPhone apps. Good for having an easy to use iPod click wheel style interface. Used in the Unplugged app.
                       DESC

  s.homepage         = "https://github.com/hoan/HTTInputDial"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Hoan Ton-That" => "hoan.tonthat@gmail.com" }
  s.source           = { :git => "https://github.com/hoan/HTTInputDial.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hoantonthat'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HTTInputDial' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
