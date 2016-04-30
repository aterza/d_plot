module DPlot
  module Readers

    #
    # +Bar+
    #
    # a collector for bar data
    #
    class Bar

      #
      # +width+
      #
      # is in millimeters
      #
      attr_reader :number, :width
  
      def initialize(n, w, scaling)
        @number = n
        @width = calculate_width(w, scaling)
      end

    private

      def calculate_width(w, scaling)
        @width = w.to_f / scaling.to_f
      end

    end

  end
end

