require 'rubygems'
require 'integrity'
require 'oauth/consumer'
require 'yammer4r'

module Integrity
  class Notifier
    class Yammer < Notifier::Base

      attr_reader :config

      def initialize(build, config = {})
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
        @message ||= <<-content
#{build.project.name}: #{short_message} (at #{build.commited_at} by #{build.commit_author.name})
 Commit Message: '#{build.commit_message}'
 Link: #{build_url}
content
      end
      
    end
  end
end
