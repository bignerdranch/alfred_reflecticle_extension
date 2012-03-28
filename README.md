Reflecticle Alfred Extension
============================

A little ruby script & xml files that let you post to Reflecticle from Alfred

Installation
------------

Setup your API Key:

    $ echo 'API_KEY' > ~/.reflecticle

Then just install dependencies and the extension itself:

    $ bundle install
    $ rake install

Usage
-----

Once installed, you can simply invoke Alfred and type:

    reflecticle Project Name Installed Reflecticle Alfred Extension!

Updating
--------

If you update this extension, be sure to 

 1. bump the version number in appcast.xml
 2. bump the version number in update.xml
 3. update the exported alfred extension in Reflecticle.alfredextension
