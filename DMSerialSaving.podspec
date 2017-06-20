Pod::Spec.new do |s|

  s.name         = "DMSerialSaving"
  s.version      = "1.0"
  s.summary      = "Magical record serial saving"
  s.homepage     = "https://github.com/DimaAvvakumov/DMSerialSaving"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Dmitry Avvakumov" => "avvakumov@it-baker.ru" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/DimaAvvakumov/DMSerialSaving.git" }
  s.source_files = "DMSerialSaving", "DMSerialSaving/*.{h,m}"
  s.public_header_files = "DMSerialSaving/DMSerialSaving.{h,m}"
  
  s.requires_arc = true

  s.dependency 'MagicalRecord'

end
