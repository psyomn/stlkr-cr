require 'stlkr'
require 'libnotify'

module Stlkr
# @author psyomn
class StalkerService
  def initialize
    @done = false
  end
  def run
    ws = load_websites
    until @done do
      ws = db_changed? ? load_websites : ws
      puts 'refresh'
      ws.each do |w|
        prev = w.hashcode
        print "Rechecking #{w} ..."
        w.fetch!
        new = w.hashcode

        if prev != new
          print " Site has changed!"
          w.insert
          notify_changed(w)
        end

        puts
      end
      sleep Stlkr::INTERVAL
    end
  end

  private

  def notify_changed(w)
    Libnotify.show(
      :body => "#{w.url}",
      :summary => "#{w.url} has changed",
      :timeout => 2.5,
      :icon_path => "/usr/share/icons/Tango/scalable/emblems/emblem-system.svg"
    )
  end

  # TODO this should simply check file timestamp and see if it has been altered
  # since last read
  def db_changed?
    true
  end

  def load_websites
    Website.all
  end
end
end
