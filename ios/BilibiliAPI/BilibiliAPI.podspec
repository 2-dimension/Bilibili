Pod::Spec.new do |s|

  s.name = 'BilibiliAPI'
  s.version = '0.1'
  s.summary = 'B站API'
  s.homepage = 'http://bilibili.com'
  s.license = { :type => 'Copyright', :text => 'Copyright (c) 2017 Yae Sakura. All rights reserved.' }
  s.authors = { 'Yae Sakura' => '949886@qq.com' }
  s.source = { :git => './' }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  #s.preserve_path = 'Modules/*'
  s.xcconfig    = { 'SWIFT_VERSION' => '4.0'}
  s.pod_target_xcconfig  =  { 'SWIFT_INCLUDE_PATHS' => "\"#{File.join(File.dirname(__FILE__), 'Modules')}\"" }
  s.source_files = 'BilibiliAPI/**/*.{h,swift}'
  s.exclude_files = 'SakuraTests/**/*.swift'
  s.vendored_libraries = '**/*.a'
  s.frameworks = 'Foundation'
  s.dependency 'Alamofire'

end
