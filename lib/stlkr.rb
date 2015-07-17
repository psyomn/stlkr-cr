require 'stlkr/version'
require 'stlkr/boot'
require 'stlkr/website'
require 'stlkr/stalker_service'

module Stlkr
  NAME = 'stlkr'
  HOME = ENV['HOME']
  CONFIGDIR = [HOME, '.config'].join('/') + '/'
  DATADIR = [CONFIGDIR, NAME].join('/') + '/'
  URIFILE = [DATADIR, 'uris'].join('/')

  # Seconds to check against a site each time
  INTERVAL = 10
end
