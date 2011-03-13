# encoding: utf-8

module Lupus
  class Archive
    attr_accessor :path

    def initialize thread
      @path   = ::File.join Dir.pwd, "#{thread.id}.zip"
      @thread = thread
    end

    def pack path = @path
      Zip::ZipFile.open path, Zip::ZipFile::CREATE do |zip|
        @thread.files.each {|file| file.save and zip.add file.name, file.path }
      end

      @thread.files.each &:delete
      Dir.unlink ::File.join ::File.dirname(@path), @thread.id
    end
  end
end
