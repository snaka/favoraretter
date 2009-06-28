#
# favoraretter.rb for Windows
#

# This software distributable under the terms of an MIT-style license.
# Copyright (c) 2009 snaka<snaka.gml@gmail.com>
#                    http://d.hatena.ne.jp/snaka72/

require 'pstore'
require 'open-uri'

LOG = 'fav.log'
def log(msg) File.open(LOG, "a") {|f| f.puts "#{Time.now} #{msg}"} end
def debug(msg)
  return unless $DEBUG
  File.open(LOG, "a") {|f| f.puts "#{Time.now} #{msg}"}
end

log "started."

FAVOTTER_BASE_URI = 'http://favotter.matope.com'
ICON_DIR = "icons/"

USER = ARGV[0] || ""


def watch

  count = 0
  doc = Nokogiri::HTML(open(FAVOTTER_BASE_URI + "/user.php?user=#{USER}"))

  $store.transaction do
    doc.css("div.entry").each do |entry|
      entry_id = entry.attribute("id").to_s.match(/status_([0-9]+)/)[1]
      user = entry.css("img.user_icon")[0].attribute("alt").to_s
      status = entry.css("span.status_text")[0].inner_text
      fav_count = (favs = entry.css("span.favotters")).inner_text

      favs.css("img.fav_icon").each do |favotter|
        favotter_name = favotter.attribute("title").to_s
        favotter_icon = favotter.attribute("src")

          if($store[entry_id])
            debug "@#{entry_id} exists"
            if($store[entry_id][favotter_name])
              debug "@#{favotter_name} exists"
              next
            end
          else
            $store[entry_id] = {}
          end

          log "#{favotter_name} #{favotter_icon} fav #{user}'s tweet #{status}"
          $growl.notify({
            :name   => "Favorare",
            :title  => "#{favotter_name} favs..",
            :text   => %Q(#{user}:"#{status}"),
            :icon   => favotter_icon
          })

          count += 1
          $store[entry_id][favotter_name] = true
          sleep(1)

      end
    end
  end

  return count
end

begin
  require 'rubygems'
  require  "win32/daemon"
  include Win32

  $store = PStore.new("./store")

  class FavoraretterDaemon < Daemon

   VERSION = "0.0.1"

    def service_main
      log "require gems..."
      require 'nokogiri'
      require 'ruby_gntp'

      log "register GNTP server..."
      $growl = GNTP.new("Favoraretter")
      $growl.register({
        :app_icon => "http://favotter.matope.com/favicon.ico",
        :notifications => [{
          :name		    => "Favorare",
          :disp_name	=> "You've got fav!",
          :enabled	  => true
        }]
      })

      log "notify stating..."
      $growl.notify({
        :name     => "Favorare",
        :title    => "Now stating favoraretter..",
        :text     => "Please wait a moment."
      })

      log "enter main loop..."
      while running?

        sleep 600
        log "fetch fav. for #{USER}"
        watch
      end
    end

    def service_stop
      log "finish."
      $growl.notify({
        :name     => "Favorare",
        :title    => "Now stopping the service.",
        :text     => "Please wait a moment."
      })
      exit!
    end
  end

  FavoraretterDaemon.mainloop

rescue Exception => err
  log "error=#{err}"
#  err.backtrace
  raise
end

# vim: ts=2 sw=2 et
