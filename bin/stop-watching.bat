@echo off
rem
rem  stop-watching.bat
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

begin
  puts "サービスを停止します。"
  Service.stop(SERVICE)
  puts "サービスを停止しました。"
rescue Exception => ex
  puts "ERR:サービスの停止で問題が発生しました"
  puts ex
end

# vim: ts=2 sw=2 et
