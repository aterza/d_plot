require "d_plot/version"

module DPlot
  PATH = File.expand_path(File.join('..', 'd_plot'), __FILE__)
end

%w(
  version
  exceptions
  drivers
  readers
  system
  models
).each { |f| require File.join(DPlot::PATH, f) }
