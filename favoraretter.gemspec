Gem::Specification.new do |s|
  s.name         = 'favoraretter'
  s.version      = '0.0.6'
#  s.platform     = Gem::Platform::CURRENT
  s.summary      = 'Watch "favorare" status and notify if "favorare" added.'
  s.description  = s.summary
  s.require_path = 'bin'

  s.files        = %w[ History.txt
                       Manifest.txt
                       README.txt
                       Rakefile
                       bin/fav-start
                       bin/fav-stop
                       bin/fav-reg
                       bin/fav-unreg
                       bin/constant.rb
                       bin/favoraretter.rb ]

  # FIXME: Wouldn't copy favoraretter to bin directory. Any workarounds?
  s.executables  = %w[ fav-start
                       fav-stop
                       fav-reg
                       fav-unreg ]

  s.add_dependency 'nokogiri',      '>= 1.3.2' 
  s.add_dependency 'ruby_gntp',     '>= 0.1.1'
  s.add_dependency 'win32-service', '>= 0.6.1'

  s.author       = 'snaka'
  s.email        = 'snaka.gml@gmail.com'
  s.homepage     = 'http://d.hatena.ne.jp/snaka72/'
end
