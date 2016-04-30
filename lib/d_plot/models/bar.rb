module DPlot
  module Models

    class Bar
      attr_accessor :number, :start_time, :end_time, :dissonance, :width, :start_pos

      def initialize(args)
        args.each { |a, v| self.send(a.to_s + '=', v) }
      end

      def dur
        self.end_time - self.start_time
      end

      def conv_width
        self.width / self.dur
      end

      def end_pos
        self.start_pos + self.width
      end

      def dissonance_pos(idx)
        l = self.dissonance[idx]
        raise DPlot::Exceptions::TimeOutOfRange unless l
        tdiff = l.time - self.start_time
        self.start_pos + (tdiff * self.conv_width)
      end

    end

  end
end
