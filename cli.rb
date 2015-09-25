# coding: utf-8

require 'thor'
require_relative 'race'

module Crawling
	require 'yaml'

	VERSION = '0.0.1'
	CONFIG = YAML.load_file('config/config.yml')

	class Cli < Thor
		include Crawling

		check_unknown_options!
		class_option 'save_to',  :type => :string, :default => File.expand_path(ENV['USERPROFILE']), :aliases => '-s', :banner => 'Any directory'
		class_option 'no_save', :type => :boolean, :default => false, :aliases => '-ns', :desc => 'Disable autosave the images'
		class_option 'silent', :type => :boolean, :default => false, :aliases => '-z', :desc => 'Silent all messages.'

		
		def self.exit_on_failure?
      		true
    	end

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

		desc 'listdogs OPTIONS', 'List of dog races'
		map %w[-ld --listdogs] => :listdogs
		option :letter, :default => "a".."z", :aliases => '-l'

		def listdogs
			dograces = Crawling::Race.new Crawling::CONFIG, options
			dograces.list_of_dogs
		end

		desc 'listcats OPTIONS', 'List of cat races'
		map %w[-lc --listcats] => :listcats
		
		def listcats
			catraces = Crawling::Race.new Crawling::CONFIG, options
			catraces.list_of_cats
		end

	end
end