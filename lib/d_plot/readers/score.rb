require 'nokogiri'

module DPlot
  module Readers

    class Score
      attr_reader :filename, :score, :systems, :scaling, :num_bars

      def initialize(fname, dummy_options = {})
        @filename = fname
        s= parse_document
        @scaling = init_scaling(s)
        init_systems(s)
      end

      alias_method :size, :num_bars

    private

      def init_scaling(s)
        s.css('defaults scaling millimeters').children.first.text.to_f
      end

      def parse_document
        res = Nokogiri::XML(File.open(self.filename)) do |config|
          config.strict.noblanks
       end
       res
      end

      def init_systems(s)
        @systems = []
        @num_bars = 0
        #
        # since parts duplicate the number of bars, we take the first part as
        # a reference to measure the score
        #
        s.css('part').first.css('measure').each do
          |m|
          unless m.css('print').empty?           # new system
            @systems << DPlot::System.new
          end
          number = m.attributes['number'].value
          width = m.attributes['width'].value.to_f
          @systems.last << Bar.new(number, width, self.scaling)
          @num_bars += 1
        end
      end

    end

  end
end
