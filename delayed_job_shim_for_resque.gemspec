# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'delayed_job_shim_for_resque/version'

Gem::Specification.new do |spec|
  spec.name          = "delayed_job_shim_for_resque"
  spec.version       = DelayedJobShimForResque::VERSION
  spec.authors       = ["Nicholas Silva"]
  spec.email         = ["nick@silvamerica.com"]
  spec.summary       = %q{Shims Delayed Job's delay and handle_asynchronously methods into Resque}
  spec.description   = %q{Shims Delayed Job's delay and handle_asynchronously methods into Resque}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.requirements << "These requirements are not listed as dependencies, as this is a shim gem and meant to be removed"
  spec.requirements << "resque at approximately 1.24.1"
  spec.requirements << "resque-scheduler at approximately 2.2.0"
  spec.requirements << "resque-retry at approximately 1.0.0"
end
