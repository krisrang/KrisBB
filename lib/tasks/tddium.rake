def cmd(c)
  system c
end

namespace :tddium do
  desc "post_build_hook"
  task :post_build_hook do
    # This build hook should only run after CI builds.
    #
    # There are other cases where we'd want to run something after every build,
    # or only after manual builds.
    return unless ENV["TDDIUM_MODE"] == "ci"
    return unless ENV["TDDIUM_BUILD_STATUS"] == "passed"

    cmd "cap deploy" or abort "couldn't deploy"
  end
end
