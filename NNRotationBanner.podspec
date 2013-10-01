Pod::Spec.new do |s|

  s.name         = "NNRotationBanner"
  s.version      = "0.0.2"
  s.summary      = "infinity loop rotation banner."
  s.description  = "You can create RotationBanner like 'app store' App's header."                   
  s.homepage     = "https://github.com/naonya3/NNRotationBanner"
  s.license      = 'MIT (example)'
  s.author       = { "Naoto Horiguchi" => "naoto.horiguchi@gmail.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/naonya3/NNRotationBanner.git", :tag => "0.0.2" }
  s.source_files = 'NNRotationBanner', 'NNRotationBanner/**/*.{h,m}'
  s.requires_arc = true
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
end
