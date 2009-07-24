require "bob/scm/abstract"

module Bob
  module SCM
    class Svn < Abstract
      def info(revision)
        dump = `svn log --non-interactive --revision #{revision} #{uri}`.split("\n")
        meta = dump[1].split(" | ")

        { :message => dump[3],
          :author  => meta[1],
          :committed_at => Time.parse(meta[2]) }
      end

      def head
        `svn info #{uri}`.split("\n").detect { |l| l =~ /^Revision: (\d+)/ }
        $1.to_s
      end

    private

      def update_code(commit)
        initial_checkout(commit) unless checked_out?(commit)
      end

      def checkout(revision)
        run "svn up -q -r#{revision}", directory_for(revision)
      end

      def initial_checkout(revision=nil)
        run "svn co -q #{uri} #{directory_for(revision)}"
      end

      def checked_out?(commit)
        File.directory?(directory_for(commit) + "/.svn")
      end
    end
  end
end
