# encoding: utf-8

require 'zip/zip'
require 'nokogiri'
require 'open-uri'

require 'lupus/post'
require 'lupus/thread'
require 'lupus/archive'

module Lupus
  class << Version = [0,1]
    def to_s; join '.' end
  end
end
