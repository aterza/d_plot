module DPlot
  module Drivers
    PATH = File.expand_path(File.join('..', 'drivers'), __FILE__)
  end
end

%w(
  base
  pic
).each { |f| require File.join(DPlot::Drivers::PATH, f) }
