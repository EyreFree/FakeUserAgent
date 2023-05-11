Pod::Spec.new do |s|
  s.name             = 'FakeUserAgent'
  s.version          = '0.2.0'
  s.summary          = 'FakeUserAgent in swift.'

  s.description      = <<-DESC
Up-to-date simple useragent faker with real world database in Swift.
                       DESC

  s.homepage         = 'https://github.com/EyreFree/FakeUserAgent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EyreFree' => 'eyrefree@eyrefree.org' }
  s.source           = { :git => 'https://github.com/EyreFree/FakeUserAgent.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EyreFree777'

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '11.0'
  s.watchos.deployment_target = '6.0'

  s.source_files = 'FakeUserAgent/Classes/**/*'
  s.resources = 'FakeUserAgent/Assets/**/*'
end
