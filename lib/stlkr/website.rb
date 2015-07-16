require 'stlkr'
module Stlkr
# This looks crudy, but it just stores websites in a file as a list. There's no
# point to use a database for something so trivial. The file
# @author psyomn
class Website
  # @return all the website urls, as a list of strings
  def self.all
  end

  # @param url is the url to append to the list of sites
  def self.insert(url)
  end

  def self.delete
  end

  class << self
    private
    # @param path is the path to the file to read
    # @return a string with the contents of the file
    def file_contents(path)
      fh = File.open(path, 'r')
      fh.close
    end
  end

end
end
