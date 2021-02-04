Pod::Spec.new do |spec|
  spec.name         = "VrInteractiveTracking"
  spec.version      = "6.0.0"
  spec.summary      = "VrInteractiveTracking"

  spec.description  = <<-DESC
  Tracking module for VideoResearch.
                   DESC

  spec.homepage     = "https://github.com/video-research/vr-ios-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = 'Video Research Ltd.'
  
  # TODO change git url
  spec.source       = { :git => "https://github.com/video-research/vr-ios-sdk.git", :tag => "#{spec.version}" }

  spec.ios.deployment_target = "9.0"
  spec.tvos.deployment_target = "9.0"

  spec.prefix_header_file = 'VrInteractiveTracking/Supporting Files/VrInteractiveTracking-Prefix.pch'

  spec.source_files  = "VrInteractiveTracking/**/*.{h,m}"
  spec.preserve_paths = ' Library/*.a'
  spec.public_header_files = "library/*.h"
  spec.library = "VrInteractiveTracking"

  spec.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/VrInteractiveTracking/Library"' }
end
