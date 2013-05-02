Pod::Spec.new do |s|
  s.name     = 'UIControl-Notifications'
  s.version  = '1.0'
  s.platform = :ios
  s.summary  = 'Make your UIControls respond to notifications and blocks instead of the old fashioned target+selector approach'
  s.homepage = 'https://github.com/myell0w/MTStatusBarOverlay'
  s.author   = { 'Joe Fabisevich' => 'github@fabisevi.ch' }
  s.source   = { :git => 'https://github.com/mergesort/UIControl-Notifications.git', :tag => '1.0' }

  s.description = 'Make your UIControls respond to notifications and blocks instead of the old fashioned target+selector approach'

  s.requires_arc = true
  s.source_files = '*.{h,m}'
end
