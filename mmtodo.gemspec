Gem::Specification.new do |s| 
  s.name         = "mmtodo"
  s.version      = "1.0.0"
  s.author       = "Mike Mitrovich"
  s.email        = "mmitrovich@gmail.com"
  #s.homepage     = "INSERT HOMEPAGE URL HERE"
  s.summary      = "A simple commandline based todo app to teach myself some ruby concepts"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'mmtodo' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end