module Bob
  module SCM
    class Git < Abstract
      def initialize(uri, branch)
        super

        unless File.directory?(File.join(Bob.directory, "cache"))
          FileUtils.mkdir(File.join(Bob.directory, "cache"))
        end
      end

      def info(commit)
        format = %Q(---%n:author: %an <%ae>%n:message: >-%n  %s%n:committed_at: %ci%n)
        YAML.load(`cd #{directory_for(commit)} && git show -s --pretty=format:"#{format}" #{commit}`).tap { |info|
          info[:committed_at] = Time.parse(info[:committed_at])
        }
      end

      def head
        `git ls-remote --heads #{uri} #{branch} | cut -f1`.chomp
      end

      private

      def update_code(commit)
        unless File.directory?("#{cache_directory}/.git")
          run "git clone -n #{uri} #{cache_directory}"
        end

        run "git fetch origin", cache_directory
        run "git checkout origin/#{branch}", cache_directory
      end

      def checkout(commit)
        unless File.directory?("#{directory_for(commit)}/.git")
          run "git clone -ns #{cache_directory} #{directory_for(commit)}"
        end

        run "git fetch origin", directory_for(commit)

        # First checkout the branch just in case the commit_id
        # turns out to be HEAD or other non-sha identifier
        run "git checkout origin/#{branch}", directory_for(commit)
        run "git reset --hard #{commit}", directory_for(commit)
      end

      def cache_directory
        File.join(Bob.directory, "cache", path)
      end
    end
  end
end
