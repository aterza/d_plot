module DPlot
  module Readers

    class Label
      attr_reader :start_time, :end_time, :bar_number

      def initialize(st, et, bn)
        @start_time = st
        @end_time = et
        @bar_number = bn
      end

    end

    class LabelCollection
      attr_reader :filename, :labels

      def initialize(fname, dummy_options = {})
        @filename = fname
        @labels = parse_labels
      end

    private

      def parse_labels
       res = {}
       File.open(self.filename, 'r') do
         |fh|
         while(!fh.eof?)
           line = fh.gets.chomp
           (s, e, l) = line.split(/\s+/, 3)
           res.update(l => Label.new(s.to_f, e.to_f, l))
         end
       end
       res
      end

    end

  end
end
