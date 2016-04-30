require 'essentia_ruby'

module DPlot
  module Readers

    class Level
      attr_reader :time, :value

      def initialize(t, v)
        @time = t
        @value = v
      end

    end

    class Dissonance
      attr_reader :filename, :levels, :options

      DEFAULT_OPTIONS = { 'sampleRate' => 44100.0, 'hopSize' => 1024, 'magnitudeThreshold' => 0.05 }

      def initialize(fname, opts = {})
        @options = DEFAULT_OPTIONS
        @options.update(opts)
        @filename = fname
        @levels = parse_levels
      end

      def range(from_value, to_value)
        raise DPlot::Exceptions::TimeOutOfRange if from_value > self.levels.last.time
        rstart = self.levels.bsearch_index { |x| x.time >= from_value }
        rend   = to_value > self.levels.last.time ? self.levels.size-1 : self.levels.bsearch_index { |x| x.time >= to_value } - 1
        self.levels[rstart..rend]
      end

    private

      include EssentiaRuby::Helpers::Dissonance

      def parse_levels
        res = []
        d = dissonance(self.filename, { 'FrameCutter' => { 'hopSize' => self.options['hopSize'] }, 'SpectralPeaks' => { 'magnitudeThreshold' => self.options['magnitudeThreshold'] }})
        step = self.options['hopSize'] / self.options['sampleRate'].to_f
        t = 0.0
        d.each do
          |lev|
          res << Level.new(t, lev)
          t += step
        end
        res
      end

    end

  end
end
