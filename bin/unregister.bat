@echo off
rem
rem  unregister.bat
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
  Service.stop(SERVICE)
rescue Exception => ex
end

begin
  Service.delete(SERVICE)
  puts "�T�[�r�X�̓o�^���������܂����B"
rescue Exception => ex
  puts "ERR:�T�[�r�X�̓o�^�����Ŗ�肪�������܂���"
  puts ex
end

# vim: ts=2 sw=2 et
