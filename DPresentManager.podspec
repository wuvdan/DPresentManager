
Pod::Spec.new do |s|
  s.name             = 'DPresentManager'
  s.version          = '0.1.0'
  s.summary          = 'A pop window.'

  s.description      = 'This a pop window by present viewController transision animation.'
  s.homepage         = 'https://github.com/wuvdan/DPresentManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wuvdan' => 'wuvdan@163.com' }
  s.source           = { :git => 'https://github.com/wuvdan/DPresentManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'DPresentManager/Classes/**/*'
end
