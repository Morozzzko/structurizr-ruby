# frozen_string_literal: true

require_relative 'lib/structurizr/version'

Gem::Specification.new do |spec|
  spec.name          = 'structurizr'
  spec.version       = Structurizr::VERSION
  spec.authors       = ['Igor S. Morozov']
  spec.email         = ['igor@morozov.is']

  spec.summary       = 'C4 model in Ruby. Wrapper for Structurizr API'
  spec.homepage      = 'https://github.com/Morozzzko/structurizr-ruby'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.files += Dir['lib/**/*.jar']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'pry'
  spec.add_dependency 'ruby-next'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'

  spec.platform = 'java'
  spec.requirements << "jar com.structurizr, structurizr-core, #{Structurizr::VERSION}"
  spec.requirements << "jar com.structurizr, structurizr-client, #{Structurizr::VERSION}"
  spec.requirements << "jar com.structurizr, structurizr-documentation, 1.1.1"
  spec.requirements << "jar com.structurizr, structurizr-graphviz, 2.2.1"
  spec.requirements << "jar com.structurizr, structurizr-export, 1.16.1"
  spec.requirements << "jar com.structurizr, structurizr-import, 1.5.0"
  spec.requirements << "jar com.structurizr, structurizr-dsl, 1.32.0"
end
