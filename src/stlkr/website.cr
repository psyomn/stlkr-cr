require "../stlkr.cr"
require "uri"
require "digest"
require "http/client"
require "yaml"

module Stlkr
class Website
  def initialize(url : String, hash : String | Nil = nil)
    @url = url
    @hashcode = hash
    @username = nil
    @password = nil

    begin
      fetch! if hash.nil?
    rescue e
      puts "Could not reach host"
      puts e
    end
  end

  def self.all
    ws = Array(Website).new
    hh = self.load_contents

    hh.each do |k,v|
      tmp_hashcode = hh[k][":hashcode"]
      tmp_url = k

      w = Website.new(tmp_url, tmp_hashcode)
      w.username = hh[k][":username"]
      w.password = hh[k][":password"]
      ws.push w
    end
    ws
  end

  def to_s
    "<Website|#{@url}|#{@hashcode}>"
  end
  def insert
    cont = Website.load_contents
    @hashcode = @hashcode == nil ? "" : @hashcode
    @username = @username == nil ? "" : @username
    @password = @password == nil ? "" : @password
    cont[@url][":hashcode"] = @hashcode
    cont[@url][":username"] = @username
    cont[@url][":password"] = @password
    Website.store_contents(cont)
    FileUtils.touch(TIMESTAMPFILE)
  end

  def self.delete(url)
    cont = Website.load_contents
    cont.delete url
    Website.store_contents(cont)
    FileUtils.touch(TIMESTAMPFILE)
  end

  def fetch!
    if @username.nil? || @password.nil?
      plain_fetch!
    else
      auth_fetch!
    end
  end

  def self.hashify(http_contents)
    Digest::MD5.hexdigest http_contents
  end

  def self.load_contents
    cont = self.file_contents(Stlkr::URIFILE)

    ret = Hash(String, Hash(String, String | Nil)).new
    YAML.parse(cont).each do |k,v|
      tmpin = Hash(String, String | Nil).new
      tmpin[":hashcode"] = v[":hashcode"].try &.to_s
      tmpin[":username"] = v[":username"].try &.to_s
      tmpin[":password"] = v[":password"].try &.to_s
      ret[k.as_s] = tmpin
    end
    ret
  end

  def self.store_contents(data_h)
    File.write(Stlkr::URIFILE, data_h.to_yaml)
  end

  def self.file_contents(path) : String
    File.read(path)
  end

  property url : String
  property hashcode : String | Nil
  property username : String | Nil
  property password : String | Nil

  private def auth_fetch!
    uri = URI.parse(@url)
    http = HTTP::Client.new(uri)
    http.basic_auth(@username, @password)
    response = http.get(uri.full_path)
    @hashcode = Website.hashify(response.body)
  end

  private def plain_fetch!
    uri = URI.parse(@url)
    contents = HTTP::Client.get(uri).body
    @hashcode = Website.hashify(contents)
  end
end
end
