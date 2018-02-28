
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shokunin/version"

Gem::Specification.new do |spec|
  spec.name          = "shokunin"
  spec.version       = Shokunin::VERSION
  spec.authors       = ["Jari Kolehmainen"]
  spec.email         = ["jari.kolehmainen@gmail.com"]

  spec.summary       = "Kubernetes cluster artisan"
  spec.description   = "Kubernetes cluster artisan"
  spec.homepage      = "https://github.com/kontena/shokunin"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "clamp", "1.2.1"
  spec.add_runtime_dependency "pastel"
  spec.add_runtime_dependency "kubeclient"
  spec.add_runtime_dependency "net-ssh"
  spec.add_runtime_dependency "net-scp"
  spec.add_runtime_dependency "dry-struct"
  spec.add_runtime_dependency "dry-validation"
  spec.add_runtime_dependency "deep_merge"
  spec.add_runtime_dependency "fugit"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7"
end
