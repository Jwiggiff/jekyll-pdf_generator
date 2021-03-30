require_relative 'lib/jekyll-pdf_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-pdf_generator"
  spec.version       = Jekyll::PdfGenerator::VERSION
  spec.authors       = ["Jwiggiff"]
  spec.email         = ["friedman.josh03@gmail.com"]

  spec.summary       = "A Jekyll plugin to generate pdfs."
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", "~> 4.1"
  spec.add_dependency "puppeteer-ruby", "~> 0.31.1"
end
