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
      
    end
  end
end
