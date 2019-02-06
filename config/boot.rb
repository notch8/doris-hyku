ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['TMPDIR'] = "/opt/doris-hyku/tmp" if ENV['RAILS_ENV'] == 'production'
require 'bundler/setup' # Set up gems listed in the Gemfile.
