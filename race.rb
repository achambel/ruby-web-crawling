# coding: utf-8

require 'mechanize'

module Crawling
	class Race
		def initialize(url)
			@agent = Mechanize.new
			@page = @agent.get(url)
		end

		def dog
			@page.images_with(class: 'icones').each do |img|
				puts img.text.strip
			end
		end
	end
end