require 'stlkr/version'
require 'stlkr/boot'
require 'stlkr/website'
require 'stlkr/stalker_service'

module Stlkr
  NAME = 'stlkr'
  HOME = ENV['HOME']

  URIFILE_NAME = 'uris'
  TIMESTAMPFILE_NAME = 'lastupdate'

  CONFIGDIR     = File.join(HOME, '.config').join
  DATADIR       = File.join(CONFIGDIR, NAME).join
  URIFILE       = File.join(DATADIR, URIFILE_NAME).join

  # Whenever a user del/adds a new site to monitor, this file is updated with the
  # current time.
  TIMESTAMPFILE = File.join(DATADIR, TIMESTAMPFILE_NAME).join

  # Seconds to check against a site each time
  INTERVAL = 10
end
