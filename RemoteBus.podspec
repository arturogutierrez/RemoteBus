Pod::Spec.new do |s|
  s.name = 'RemoteBus'
  s.version = '1.0.0'
  s.license = 'MIT'
  
  s.homepage = 'https://github.com/arturogutierrez/RemoteBus'
  s.summary = 'A bus implementation to pass messages between iOS apps and extensions.'
  s.author = { 'Arturo Gutierrez' => 'arturo.gutierrez@gmail.com' }
  
  s.platform = :ios, '7.0'
  s.frameworks = 'Foundation'
  s.requires_arc = true
  
  s.source = { :git => 'https://github.com/arturogutierrez/RemoteBus.git', :tag => s.version.to_s }
  s.source_files = 'Classes/*.{h,m}'
end
