require 'stlkr/version'
require 'stlkr/boot'
require 'stlkr/website'

module Stlkr
  NAME = 'stlkr'
  HOME = ENV['HOME']
  CONFIGDIR = [HOME, '.config'].join('/') + '/'
  DATADIR = [CONFIG, NAME].join('/') + '/'
  URIFILE = [DATADIR, 'uris'].join('/')
end
