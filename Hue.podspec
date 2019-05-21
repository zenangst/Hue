Pod::Spec.new do |s|
  s.name             = "Hue"
  s.summary          = "The all-in-one coloring utility that you'll ever need."
  s.version          = "5.0.0"
  s.homepage         = "https://github.com/zenangst/Hue"
  s.license          = 'MIT'
  s.author           = { "Christoffer Winterkvist" => "christoffer@winterkvist.com" }
  s.source           = { :git => "https://github.com/zenangst/Hue.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zenangst'

  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.ios.source_files = 'Source/iOS+tvOS/**/*'
  s.ios.frameworks = 'UIKit'

  s.tvos.deployment_target = '9.0'
  s.tvos.source_files = 'Source/iOS+tvOS/**/*'
  s.tvos.frameworks = 'UIKit'

  s.osx.deployment_target = '10.11'
  s.osx.source_files = 'Source/macOS/**/*'
  s.osx.frameworks = 'AppKit'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end
