#
# Be sure to run `pod lib lint ZYBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYBox'
  s.version          = '0.0.5'
  s.summary          = 'ZYBox'
  s.description      = <<-DESC
    Zhi Da Swift Kit
    DESC
  s.license          = { :type => 'MIT', :text => <<-LICENSE
    MIT
    LICENSE
  }
  s.homepage         = 'https://github.com/OFFFIELD/ZYBox'
  s.author           = { 'ZhiDa' => 'iOS8899@126.com' }
  s.source           = { :git => 'https://github.com/OFFFIELD/ZYBox.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.frameworks = 'UIKit', 'Foundation', 'AVKit', 'Photos', 'MediaPlayer', 'CoreLocation', 'CoreGraphics'
  # s.source_files = 'ZYBox/Classes/*'
  # s.resource_bundles = {
  #   'ZYBox' => ['ZYBox/Assets/*.xcassets']
  # }
  
  s.subspec 'ZYObject' do |ss|
    ss.resource     = 'ZYBox/Classes/ZYObject/*.xcassets'
    ss.source_files = 'ZYBox/Classes/ZYObject/*'
  end
  
end
