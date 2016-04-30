module DPlot
  module Exceptions

    class DPlotException < StandardError; end
    class TimeOutOfRange < DPlotException; end

  end
end
