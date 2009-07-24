module Bob
  module Test
    BuildableStub = Struct.new(:scm, :uri, :branch, :commit, :build_script) do
      include Bob::Buildable

      def self.for(repo, commit)
        scm = (Bob::Test::GitRepo === repo) ? :git : :svn
        uri =
          if scm == :git
            repo.path
          else
            "file://#{SvnRepo.server_root}/#{repo.name}"
          end
        # move to repo
        branch = (scm == :git) ? "master" : ""
        build_script = "./test"

        new(scm, uri, branch, commit, build_script)
      end

      attr_reader :repo, :status, :output, :commit_info

      def initialize(*args)
        super

        @status = nil
        @output = ""
        @commit_info = {}
      end

      def start_building(commit_id, commit_info)
        @commit_info = commit_info
      end

      def finish_building(commit_id, status, output)
        @status = status ? :successful : :failed
        @output = output
      end
    end
  end
end
