# encoding: utf-8

require 'grape'
require 'twilio-ruby'

require_relative 'patterns'
require_relative 'ex-em-el'


module TextChimp
  class API < Grape::API
    version 'v1'

    format(:xml)
    params do
      requires :AccountSid, type: String, desc: 'Twilio Account Sid'
      requires :SmsSid, type: String, desc: 'Unique SMS ID'
      requires :From, type: String, desc: 'SMS number that sent message'
      requires :To, type: String, desc: 'Twilio number that received message'
      requires :Body, type: String, 
                      # regexp: Patterns::EMAIL_REGEXP,
                      desc: 'The Body response; should contain an e-mail address'
      optional :FromCity, type: String
      optional :FromState, type: String
      optional :FromZip, type: String
      optional :FromCountry, type: String
    end
    post '/' do
      puts params.inspect
      email = params[:Body].scan(Patterns::EMAIL_REGEXP).first
      if email
        # valid e-mail address. Subscribe
        # @TODO: ACTUALLY SUBSCRIBE




        Twilio::TwiML::Response.new do |r|
          r.Sms "The e-mail address #{email} has been subscribed. Thank you!"
        end.text.extend(ExEmEl)
        # return success response.
      else
        Twilio::TwiML::Response.new do |r|
          r.Sms "OH NO. An e-mail address wasn't included in your response.\n" +
                "Please reply with an e-mail address."
        end.text.extend(ExEmEl)
      end
    end
  end
end
