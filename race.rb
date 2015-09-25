# coding: utf-8

require 'mechanize'

module Crawling
	class Race

		def initialize(config, options)
			@config = config
			@agent = Mechanize.new
			@options = options
		end

		def list_of_dogs
			path = File.join(@config['race']['url'], @config['race']['dog_url'])

			letter = @options.letter.split('..') if @options.letter.is_a?(String)
			letter = Range.new(letter.first, letter.last) if letter.is_a?(Array)
			letter = @options.letter if @options.letter.is_a?(Range)

			letter.each do |lt|
				@page = @agent.get(File.join(path, lt))
				@page.images_with(class: 'icones').each do |race|
					puts race.text.strip unless @options.silent
					save_to(race) unless @options.no_save
				end
			end

		end

		def list_of_cats
			path = File.join(@config['race']['url'], @config['race']['cat_url'])
			
			@page = @agent.get(path)

			@page.images_with(class: 'icones').each do |race|
				puts race.text.strip unless @options.silent
				save_to(race) unless @options.no_save
			end

		end

		def save_to(race)
			basepath = File.expand_path(@options.save_to)
			directory = "#{race.text.strip}"
			filename = File.join(basepath, directory, race.fetch.filename)
			puts "Save image of race #{directory} in #{filename} ..." unless @options.silent
			race.fetch.save filename unless @options.no_save

			logfile = File.join(basepath, 'log.txt')
			File.open(logfile, 'a') { |f| f.write "#{race.text.strip};#{filename}\n" }
		end
	end
end