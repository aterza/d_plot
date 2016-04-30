module DPlot
  module Models
    PATH = File.expand_path(File.join('..', 'models'), __FILE__)
  end
end

%w(
  bar
  aggregator
).each { |f| require File.join(DPlot::Models::PATH, f) }
