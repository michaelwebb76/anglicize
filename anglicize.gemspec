$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'anglicize/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'anglicize'
  s.version     = Anglicize::VERSION
  s.authors     = ['Michael Webb']
  s.email       = ['moggyboy@gmail.com']
  s.homepage    = 'http://github.com/moggyboy/anglicize'
  s.summary     = 'Converts strings from American spelling to English spelling and vice versa.'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard'
end
