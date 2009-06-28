@echo off
rem
rem  register.bat
rem
rem  Copyright (c) 2009 snaka <snaka.gml@gmail.com>
rem

ruby -x -Ks "%~f0"
pause
exit

#! ruby
require "readline"

require "rubygems"
require "win32/service"
include Win32

require "constant"

def register(user)
  user = user || ''
  puts "#{user_display_name(user)}のふぁぼられ監視サービスを登録します。"

  if Service.exists?(SERVICE)
    puts "ERR: サービスは既に登録されています。"
  else
    Service.create(SERVICE, nil,
      :service_type   => Service::WIN32_OWN_PROCESS,
      :description    => "Favoraretter daemon",
      :start_type     => Service::AUTO_START,
      :error_control  => Service::ERROR_NORMAL,
      :binary_path_name => %("c:\\Program Files\\ruby-1.8\\bin\\rubyw.exe" -C"#{current_path}" favoraretter.rb #{user}),
      :display_name     => "Favoraetter daemon!"
    )
    puts "ふぁぼられ監視サービスを登録しました。"
  end
end

def user_display_name(user)
  if user == ''
    return 'みんな'
  end
  return user
end

def current_path
  Dir.pwd.gsub(File::Separator, File::ALT_SEPARATOR)
end

puts <<EOS
ふぁぼられを監視したいユーザーのidを入力してください。
入力を省略した場合は「ふぁぼったー」のページに表示される全てのユーザーの
ふぁぼられを監視します。
EOS
user = Readline.readline('userid?> ', true)

register user

# vim: ts=2 sw=2 et ft=ruby
