Pod::Spec.new do |s|
  s.name             = "SwiftTools"
  s.version          = "1.1.14"
  s.summary          = "Tools for Swift development."
  s.homepage         = "https://github.com/jwitcig/SwiftTools"
  s.license          = 'Code is MIT.'
  s.author           = { "Jonah" => "jwitcig@gmail.com" }
  s.source           = { :git => "https://github.com/jwitcig/SwiftTools.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/jonahwitcig'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'SwiftTools/**/*'
  # s.resources = 'Pod/Assets/*'

  s.frameworks = 'UIKit'
  s.module_name = 'SwiftTools'
end
