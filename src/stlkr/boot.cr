require "../stlkr"
require "file_utils"

module Stlkr
class Boot
  def self.up!
    FileUtils.mkdir_p Stlkr::DATADIR
    FileUtils.touch Stlkr::URIFILE
  rescue ex
    puts "problem creating datadir, or urifile"
    puts ex
  end
end
end
