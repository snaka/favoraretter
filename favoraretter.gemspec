Gem::Specification.new do |s|
  s.name         = 'favoraretter'
  s.version      = '0.0.4'
#  s.platform     = Gem::Platform::CURRENT
  s.summary      = 'Watch "favorare" status and notify if "favorare" added.'
  s.description  = s.summary
  s.require_path = 'bin'

  s.files        = %w[ History.txt
                       Manifest.txt
                       README.txt
                       Rakefile
                       bin/start-watching.bat
                       bin/stop-watching.bat
                       bin/register.bat
                       bin/unregister.bat
                       bin/favoraretter.rb ]

  s.executables  = %w[ start-watching.bat 
                       stop-watching.bat
                       register.bat
                       unregister.bat ]

  s.add_dependency 'nokogiri',      '>= 1.3.2' 
  s.add_dependency 'ruby_gntp',     '>= 0.1.1'
  s.add_dependency 'win32-service', '>= 0.6.1'

  s.author       = 'snaka'
  s.email        = 'snaka.gml@gmail.com'
  s.homepage     = 'http://d.hatena.ne.jp/snaka72/'
end
