# stlkr

* [Homepage](https://github.com/psyomn/stlkr#readme)
* [Issues](https://github.com/psyomn/stlkr/issues)
* [Documentation](http://rubydoc.info/gems/stlkr/frames)
* [Email](mailto:lethaljellybean at gmail.com)

## Description

This is a port of the stlkr gem I wrote into a crystal shard. The
purpose was mainly curiosity in the easiness of migration. Use at own
risk.

## Features

You first need to add a few sites to your collection:

    stlkr -a http://www.google.com
    stlkr -a http://www.textfiles.com/computers/144disk.txt
    stlkr -a http://www.nhk.or.jp

You can also add basic password protected sites like this:

    stlkr -a http://www.somplace.com/protectedpage.html -u username -p password

Then you can start the service this way:

    stlkr -z

You can list the current sites you're stalking this way:

    stlkr -ls

And you can remove a site this way:

    stlkr -d http://www.google.com

Everything is stored in text form inside a yaml file:

    $HOME/.config/stlkr/uris

## Examples

    require 'stlkr'

## Install

    $ gem install stlkr

## Copyright

Copyright (c) 2015 psyomn

## LICENSE

MIT
