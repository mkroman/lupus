# encoding: utf-8

module Lupus
  class Post
    class File
      attr_accessor :name, :path, :address

      def initialize address, thread
        @name    = ::File.basename address
        @path    = ::File.join Dir.pwd, thread.id, @name
        @thread  = thread
        @address = URI address
      end

      def save
        return if ::File.exists? @path

        Dir.mkdir ::File.dirname @path unless ::Dir.exists? ::File.dirname @path

        ::File.open @path, 'w+' do |file|
          http = Net::HTTP.new @address.host

          http.request_get @address.path do |response|
            response.read_body {|chunk| file.write chunk }
          end
        end
      end

      def delete
        ::File.unlink path if ::File.exists? path
      end

      alias_method :url, :address
    end

    def initialize element, thread
      @thread  = thread
      @element = element
    end

    def file
      if link = @element.at(".filesize a")
        @file ||= File.new link['href'], @thread
      end
    end
  end
end
