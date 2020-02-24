#
# Be sure to run `pod lib lint CNTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CNTools'
  s.version          = '0.1.0'
  s.summary          = 'CNMTools iOS常用类库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS常用 分类 | 宏 | 倒计时等类库
                       DESC

  s.homepage         = 'https://github.com/StephentTom/CNTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'StephentTom' => '857329255@qq.com' }
  s.source           = { :git => 'https://github.com/StephentTom/CNTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'CNTools/Classes/**/*'
  
  s.subspec "cncategory" do |cncategory|
      cncategory.source_files = 'CNTools/Classes/cncategory/*.{h,m}'
  end
  
  s.subspec "cnnetWorkingStatus" do |cnnetWorkingStatus|
      cnnetWorkingStatus.source_files = 'CNTools/Classes/cnnetWorkingStatus/*.{h,m}'
  end
  
  s.subspec "cnutils" do |cnutils|
      cnutils.source_files = 'CNTools/Classes/cnutils/*.{h,m}'
  end
  
  s.subspec "cnmacroes" do |cnmacroes|
      cnmacroes.source_files = 'CNTools/Classes/cnmacroes/*.h'
  end
  
  # s.resource_bundles = {
  #   'CNTools' => ['CNTools/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
