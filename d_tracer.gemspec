# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'd_tracer/version'

Gem::Specification.new do |spec|
  spec.name          = "d_tracer"
  spec.version       = DTracer::VERSION
  spec.authors       = ['Nicola Bernardini', 'Anna Terzaroli']
  spec.email         = ['nicb@sme-ccppd.org', 'anna.giw@libero.it']
  spec.summary       = %q{DTracer is a dissonance index measurement and tracing tool}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = 'https://github.com/nicb/d_tracer'
  spec.license       = "GNU GPL 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
