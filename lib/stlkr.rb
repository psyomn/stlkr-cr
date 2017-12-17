require 'stlkr/version'
require 'stlkr/boot'
require 'stlkr/website'
require 'stlkr/stalker_service'

module Stlkr
  NAME = 'stlkr'
  HOME = ENV['HOME']

  URIFILE_NAME = 'uris'
  TIMESTAMPFILE_NAME = 'lastupdate'

  CONFIGDIR     = File.join(HOME, '.config')
  DATADIR       = File.join(CONFIGDIR, NAME)
  URIFILE       = File.join(DATADIR, URIFILE_NAME)

  # Whenever a user del/adds a new site to monitor, this file is updated with the
  # current time.
  TIMESTAMPFILE = File.join(DATADIR, TIMESTAMPFILE_NAME)

  # Seconds
  INTERVAL = 60 * 60
end
