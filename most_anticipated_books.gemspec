
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "most_anticipated_books/version"

Gem::Specification.new do |spec|
  spec.name          = "most_anticipated_books"
  spec.version       = MostAnticipatedBooks::VERSION
  spec.authors       = ["Rhiannon Shoults"]
  spec.email         = ["rhiannon.csw@gmail.com"]

  spec.summary       = %q{A CLI app for providing information about books from The Millions Most Anticipated Books Preview.}
  spec.homepage      = "https://github.com/rhiannoncs/most-anticipated-books-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables = ["most-anticipated-books"]
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri"
end
