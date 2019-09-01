
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "movie_premier/version"

Gem::Specification.new do |spec|
  spec.name          = "movie-premier-cli"
  spec.version       = MoviePremier::VERSION
  spec.authors       = ["Mobola Moronto"]
  spec.email         = ["t2wycemo@gmail.com"]

  spec.summary       = %q{Movies Coming Soon}
  spec.description   = %q{Movies Coming Soon}
  spec.homepage      = "https://learn.co"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["movie-premier"]
  spec.require_paths = ["lib", "lib/movie_premier"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
