require 'stlkr'
require 'fileutils'

module Stlkr
# This takes care of some booting things that need to be executed each time the
# software starts. An example would be checking for data files.
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
