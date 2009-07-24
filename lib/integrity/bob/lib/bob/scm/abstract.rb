module Bob
  module SCM
    class Abstract
      attr_reader :uri, :branch

      def initialize(uri, branch)
        @uri    = Addressable::URI.parse(uri)
        @branch = branch
      end

      # Checkout the code at the specified <tt>commit</tt> and call the
      # passed block.
      def with_commit(commit)
        update_code(commit)
        checkout(commit)
        yield
      end

      # Directory where the code will be checked out for the given
      # <tt>commit</tt>.
      def directory_for(commit)
        File.join(Bob.directory, "#{path}-#{commit}")
      end

      # Get some information about the specified <tt>commit</tt>.
      # Returns a hash with:
      #
      # [<tt>:author</tt>]       Commit author's name and email
      # [<tt>:message</tt>]      Commit message
      # [<tt>:committed_at</tt>] Commit date (as a <tt>Time</tt> object)
      def info(commit)
        raise NotImplementedError
      end

      # Return the identifier for the last commit in this branch of the
      # repository.
      def head
        raise NotImplementedError
      end

      protected

      def run(command, directory=nil)
        command = "(#{directory ? "cd #{directory} && " : ""}#{command} &>/dev/null)"
        Bob.logger.debug(command)
        system(command) || raise(Error, "Couldn't run SCM command `#{command}`")
      end

      def path
        @path ||= "#{uri}-#{branch}".
          gsub(/[^\w_ \-]+/i, '-'). # Remove unwanted chars.
          gsub(/[ \-]+/i, '-').     # No more than one of the separator in a row.
          gsub(/^\-|\-$/i, '')      # Remove leading/trailing separator.
      end
    end
  end
end
