Pod::Spec.new do |s|
  s.name             = "Hue"
  s.summary          = "The all-in-one coloring utility that you'll ever need."
  s.version          = "3.0.1"
  s.homepage         = "https://github.com/hyperoslo/Hue"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/Hue.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.ios.source_files = 'Source/iOS/**/*'
  s.ios.frameworks = 'UIKit'

  s.tvos.deployment_target = '9.0'
  s.tvos.source_files = 'Source/iOS/**/*'
  s.tvos.frameworks = 'UIKit'

  s.osx.deployment_target = '10.11'
  s.osx.source_files = 'Source/Mac/**/*'
  s.osx.frameworks = 'AppKit'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
