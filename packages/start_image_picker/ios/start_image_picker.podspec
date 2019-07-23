#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'start_image_picker'
  s.version          = '0.0.1'
  s.summary          = 'A better Flutter plugin that shows an image picker.'
  s.description      = <<-DESC
A better Flutter plugin for selecting images from the Android and iOS image
library, and taking new pictures with the camera.
                       DESC
  s.homepage         = 'https://github.com/qazyn951230/start_point_flutter/tree/master/packages/start_image_picker'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nan Yang' => 'qazyn951230@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.frameworks = 'AVFoundation', 'CoreServices', 'Photos'
  s.ios.framework = 'UIKit'
  s.ios.deployment_target = '10.0'
end

