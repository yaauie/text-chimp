# encoding: utf-8
require File.expand_path('lib/text-chimp',File.dirname(__FILE__))


begin
  raw_config = YAML.load(File.open(File.expand_path('../text-chimp.yaml', __FILE__),&:read))
  puts raw_config.inspect
  CONFIG = {}
  CONFIG[:contact] = {}
  CONFIG[:contact][:name] = raw_config.fetch('contact').fetch('name')
  CONFIG[:contact][:address] = raw_config.fetch('contact').fetch('address')
  CONFIG[:mailchimp] = {}
  CONFIG[:mailchimp][:apikey] = raw_config.fetch('mailchimp').fetch('apikey')
  CONFIG[:mailchimp][:list_id] = raw_config.fetch('mailchimp').fetch('list_id')
  CONFIG.tap {|conf| conf.map {|k,v| v.freeze } }.freeze
rescue
  raise "There was a problem loading config from text-chimp.yaml: #{$!}"
end

# TODO: put this elsewhere?
require 'mailchimp'
MAILCHIMP_CLIENT = Mailchimp::API.new(CONFIG[:mailchimp][:apikey])

run TextChimp::API
