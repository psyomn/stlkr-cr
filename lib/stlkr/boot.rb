require 'stlkr'
require 'fileutils'

module Stlkr
class Boot
  def self.up!
    FileUtils.mkdir_p Stlkr::DATADIR
    FileUtils.touch Stlkr::URIFILE
  rescue => e
    puts "problem creating datadir, or urifile"
    pute e
  end
end
end
