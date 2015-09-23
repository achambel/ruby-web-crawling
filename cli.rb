# coding: utf-8

require 'thor'
require_relative 'race'

module Crawling
	require 'yaml'

	VERSION = '0.0.1'
	CONFIG = YAML.load_file('config/config.yml')

	class Cli < Thor
		include Crawling

		desc 'version', 'Display Crawling version'
		map %w[-v --version] => :version

		def version
			say "Crawling #{Crawling::VERSION}"
		end

		desc 'config', 'Display all configurations'
		map %w[-c --config] => :config

		def config
			say "Showing configurations #{Crawling::CONFIG}"
		end

		desc 'dograces', 'List of dog races'
		map %w[-d --dograces] => :dog_races

		def dog_races
			url = File.join(Crawling::CONFIG['race']['url'], Crawling::CONFIG['race']['dog_url'])
			dograces = Crawling::Race.new url
			say dograces.dog
		end
	end
end