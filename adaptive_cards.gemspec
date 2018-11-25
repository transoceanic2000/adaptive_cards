
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "adaptive_cards/version"

Gem::Specification.new do |spec|
  spec.name          = "adaptive_cards"
  spec.version       = AdaptiveCards::VERSION
  spec.authors       = ["Bruce Bondah-Davidson"]
  spec.email         = ["bruce@transoceanic.org.uk"]

  spec.summary       = %q{Gem to author Adaptive Cards for use with Microsoft Office 365 tools, e.g. Teams}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/transoceanic2000/adaptive_cards"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/transoceanic2000/adaptive_cards"
    spec.metadata["changelog_uri"] = "https://github.com/transoceanic2000/adaptive_cards/CHANGELOG.md"
  else
     "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.glob("lib/**/*") + %w(README.md)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
