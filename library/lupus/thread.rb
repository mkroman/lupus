# encoding: utf-8

module Lupus
  class Thread
    attr_accessor :address

    def initialize address
      @address = URI address
    end

    def id
      @page.at("input[@name='resto']")['value']
    end

    def posts
      @posts ||= page.css("td.reply").to_a.map {|element| Post.new element, self }
    end

    def files
      @files ||= posts.map(&:file).compact
    end

  private

    def page; @page ||= Nokogiri::HTML open @address end
  end
end
