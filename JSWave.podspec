Pod::Spec.new do |s| 
  s.name     = 'JSWave' 
  s.version  = '1.0.1' 
  s.license  = 'MIT' 
  s.summary  = "JSWave animation" 
  s.homepage = 'https://github.com/Josin22/JSWave' 
  s.authors  = { 'Josin' => 'josin.mc@gmail.com' } 
  s.source   = {  :git => "https://github.com/Josin22/JSWave.git", :tag => "1.0.1"}
  s.source_files  = "Classes/*.{h,m}" 
  s.frameworks = 'UIKit' 
  s.platform     = :ios, '7.0'   
end 