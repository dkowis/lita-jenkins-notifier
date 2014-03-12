Gem::Specification.new do |spec|
  spec.name          = "lita-jenkins-notifier"
  spec.version       = "0.0.1"
  spec.authors       = ["David Kowis"]
  spec.email         = ["dkowis@shlrm.org"]
  spec.description   = %q{Reports notifications from the jenkins notification plugin}
  spec.summary       = %q{Sends notifications based on reporting from: https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin}
  spec.homepage      = "http://github.com/dkowis/lita-jenkins-notifier"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
