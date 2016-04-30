module DPlot
  module Models

    #
    # +Aggregator+
    #
    # Options:
    #
    # - basedir: the base directory for this example (default: './')
    # - magnitudeThreshold: the signal threshold under which no spectral
    #   analysis is performed (default: 0.05)
    # - outdir: the directory where to deposit the output files
    #
    class Aggregator
      attr_reader :basename, :dissonance, :score, :label_collection, :options, :systems

      DEFAULT_OPTIONS = { 'magnitudeThreshold' => 0.01, 'basedir' => './', 'outdir' => './' }

      def initialize(bname, opts = {})
        @options = DEFAULT_OPTIONS
        @options.update(opts)
        @basename = bname
        initialize_readers
        initialize_systems
      end

      def plot
        sys_no = 1
        drv = self.class.print_driver
        self.systems.each do
          |s|
          filename = "%s_%03d.pic" % [ self.basename, sys_no ]
          drv.file_handle = File.open(File.join(self.options['outdir'], filename), 'w')
          drv.start_header
          drv.header(s.width, s.height)
          drv.output(s)
          drv.trailer
          drv.file_handle.close
          sys_no += 1
        end
      end

      class << self

        @@print_driver_name = 'pic'
        @@print_driver = nil

        def print_driver_name=(pd)
          @@print_driver_name = pd
          @@print_driver = nil
        end

        def print_driver
          unless @@print_driver
            klass = DPlot::Drivers.const_get(@@print_driver_name.capitalize)
            @@print_driver = klass.new
          end
          @@print_driver
        end

      end

    private

      def initialize_systems
        @systems = []
        last_pos = 0.0
        last_time = 0.0
        t_start = 0.0
        self.score.systems.each do
          |s|
          @systems << DPlot::System.new
          sys = @systems.last
          sys.start_pos = last_pos
          sys.start_time = last_time
          s.each do
            |b|
            l = self.label_collection.labels[b.number.to_s]
            if l
              begin
                args =
                {
                  number: b.number, start_time: l.start_time, end_time: l.end_time,
                  dissonance: self.dissonance.range(l.start_time, l.end_time),
                  width: b.width, start_pos: last_pos - sys.start_pos,
                }
                sys << Bar.new(args)
              rescue DPlot::Exceptions::TimeOutOfRange
              # do not do anything
              end
              last_pos = last_pos + b.width
              last_time = sys.last.end_time
            end
          end
        end
      end

      READERS =
      {
        dissonance: { suffix: '.mp3', reader: DPlot::Readers::Dissonance, options: [ 'magnitudeThreshold' ] },
        label_collection: { suffix: '', reader: DPlot::Readers::LabelCollection, options: [] },
        score: { suffix: '.xml', reader: DPlot::Readers::Score, options: [] },
      }

      def initialize_readers
        path = File.join(self.options['basedir'], self.basename)
        @dissonance = initialize_reader(:dissonance, path)
        @label_collection = initialize_reader(:label_collection, path)
        @score = initialize_reader(:score, path)
      end

      def initialize_reader(el, path)
        sel = READERS[el]
        opts = {}
        sel[:options].each { |o| opts.update(o => self.options[o]) }
        sel[:reader].new([path, sel[:suffix]].join, opts)
      end

    end

  end
end
