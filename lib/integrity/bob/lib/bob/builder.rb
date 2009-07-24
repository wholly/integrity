module Bob
  # A Builder will take care of building a buildable (wow, you didn't see
  # that coming, right?).
  class Builder
    attr_reader :buildable

    # Instantiate the Builder, passing an object that understands
    # the <tt>Buildable</tt> interface.
    def initialize(buildable)
      @buildable = buildable
    end

    # This is where the magic happens:
    #
    # 1. Check out the repo to the appropriate commit.
    # 2. Notify the buildable that the build is starting.
    # 3. Run the build script on it in the background.
    # 4. Reports the build back to the buildable.
    def build
      Bob.logger.info "Building #{buildable.commit} of the #{buildable.scm} repo at #{buildable.uri}"

      in_background do
        scm.with_commit(commit) {
          buildable.start_building(commit, scm.info(commit))
          build_status, build_output = run_build_script
          buildable.finish_building(commit, build_status, build_output)
        }
      end
    end

    private

    def commit
      @commit ||= buildable.commit == :head ? scm.head : buildable.commit
    end

    def run_build_script
      build_output = nil

      Bob.logger.debug("Running the build script for #{buildable.uri}")
      IO.popen(build_script, "r") { |output| build_output = output.read }
      Bob.logger.debug("Ran build script `#{build_script}` and got:\n#{build_output}")

      [$?.success?, build_output]
    end

    def build_script
      "(cd #{scm.directory_for(commit)} && #{buildable.build_script} 2>&1)"
    end

    def scm
      @scm ||= SCM.new(buildable.scm, buildable.uri, buildable.branch)
    end

    def in_background(&block)
      Bob.engine.call(block)
    end
  end
end
