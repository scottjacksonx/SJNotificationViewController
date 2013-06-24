Pod::Spec.new do |s|
  s.name     = 'SJNotificationViewController'
  s.version  = '1.1'
  s.license  = 'MIT'
  s.summary  = 'Lightweight notifications in iOS apps'
  s.author   = { 'Scott Jackson' => 'scottjacksonx@gmail.com' }
  s.source   = { :git => 'git://github.com/scottjacksonx/SJNotificationViewController.git', :tag => '1.1' }
  s.homepage = 'http://github.com/scottjacksonx/SJNotificationViewController'
  s.source_files = 'SJNotificationViewController{.h,.m,.xib}'
  s.framework = 'QuartzCore'

  s.platform = :ios
end