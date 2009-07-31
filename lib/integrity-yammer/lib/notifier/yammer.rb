require 'rubygems'
require 'integrity'
require 'oauth/consumer'
#require 'yammer4r'
require 'vendor/yammer4r/lib/yammer4r'

module Integrity
  class Notifier
    class Yammer < Notifier::Base

      attr_reader :config

      def initialize(commit, config = {})
        @yammer_client = ::Yammer::Client.new(:config => config['oauth_yml']) 
        super
      end
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def deliver! 
        @yammer_client.message(:post, :body => message)
      end

      def message
        build = @commit
        @message ||= <<-content
 #{build.project.name}: #{full_message} 
content
      end  
      
      def deliver_custom_message(msg)
        @yammer_client.message(:post, :body => msg) 
      end  
      
        def deployment_enabled?   # if this method returns true , integrity will take one step further and call deployment_task and post notification to yammer about deployment status
          false
        end  

        def deployment_task  # returns a string that needs to be passed to Kernel#system
           "echo " # any shell script here    , example rake deploy   
        end
      
    end
  end
end
