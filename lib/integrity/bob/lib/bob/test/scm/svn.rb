require File.dirname(__FILE__) + "/abstract"
require "hpricot"

module Bob::Test
  class SvnRepo < AbstractSCMRepo
    def self.server_root
      @root ||= File.join(Bob.directory, "svn")
    end

    attr_reader :remote

    def initialize(name, base_dir=Bob.directory)
      super

      @path   = File.join(base_dir, "svn-#{name}")
      @remote = File.join(SvnRepo.server_root, name.to_s)
    end

    def create
      create_remote

      run "svn checkout file://#{remote} #{path}"

      add_commit("First commit") do
        run "echo 'just a test repo' >> README"
        add "README"
      end
    end

    def destroy
      FileUtils.rm_r(remote) if File.directory?(remote)
      super
    end

    def commits
      Dir.chdir(path) do
        doc = Hpricot::XML(`svn log --xml`)

        (doc/:log/:logentry).inject([]) { |commits, commit|
          commits << { :identifier => commit["revision"],
            :message      => commit.at("msg").inner_html,
            :committed_at => Time.parse(commit.at("date").inner_html) }
        }.reverse
      end
    end

    alias_method :short_head, :head

    protected
      def add(file)
        run "svn add #{file}"
      end

      def commit(message)
        run %Q{svn commit -m "#{message}"}
        run "svn up"
      end

    private
      def create_remote
        FileUtils.mkdir(SvnRepo.server_root)

        run "svnadmin create #{remote}"

        File.open(File.join(remote, "conf", "svnserve.conf"), "w") { |f|
          f.puts "[general]"
          f.puts "anon-access = write"
          f.puts "auth-access = write"
        }
      end
  end
end
