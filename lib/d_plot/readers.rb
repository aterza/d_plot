module DPlot
  module Readers
    PATH = File.expand_path(File.join('..', 'readers'), __FILE__)
  end
end

%w(
  bar
  score
  label_collection
  dissonance
).each { |f| require File.join(DPlot::Readers::PATH, f) }

