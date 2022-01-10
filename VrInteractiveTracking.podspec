Pod::Spec.new do |spec|
  spec.name         = "VrInteractiveTracking"
  spec.version      = "6.1.0"
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

  spec.source_files = 'VrInteractiveTracking/Library/*.h'
  spec.preserve_paths = 'VrInteractiveTracking/Library/*.a'
  spec.public_header_files = "VrInteractiveTracking/library/*.h"
  spec.library = "VrInteractiveDataV6"

  spec.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/VrInteractiveTracking/VrInteractiveTracking/Library' }
end
