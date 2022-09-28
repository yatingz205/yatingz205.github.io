Gem::Specification.new do |spec|
	spec.name          = "the-plain-academic"
	spec.version       = "1.0.0"
	spec.authors       = ["Breno Viana"]
	spec.email         = ["brenoviana@lcc.ufrn.br"]

	spec.summary       = "A minimalist Jekyll theme for academics"
	spec.homepage      = "https://github.com/brenov/the-plain-academic"
	spec.license       = "MIT"

	spec.metadata["plugin_type"] = "theme"

	spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|(LICENSE|README)((\.(txt|md|markdown)|$)))!i) }

	spec.add_runtime_dependency "jekyll", "~> 3.5"

	spec.add_development_dependency "bundler", "~> 1.15"
	spec.add_development_dependency "rake", "~> 12.0"
end
