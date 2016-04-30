module DPlot

  #
  # +System+
  #
  # is simply an +Array+ of +Bar+s with some extra methods
  #
  class System < Array

    DEFAULT_HEIGHT = 20.0 * 2 # we double the height to compensate the loss of energy of the Hamming window (?)

    attr_writer :start_pos, :height, :start_time

    def <<(bar)
      raise ArgumentError, "#{self.class.name} accepts only Bar classes" unless (bar.kind_of?(DPlot::Readers::Bar) || bar.kind_of?(DPlot::Models::Bar))
      super
    end

    def width
      res = 0.0
      self.each { |b| res += b.width }
      res
    end

    def height
      @height ||= DEFAULT_HEIGHT
    end

    def start_pos
      @start_pos ||= 0.0
    end

    def start_time
      @start_time ||= 0.0
    end

  end

end
