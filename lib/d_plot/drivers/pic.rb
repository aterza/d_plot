require 'byebug'

module DPlot
  module Drivers

    class Pic < Base

      PIC_TEMPLATE_DIR = File.expand_path(File.join(['..'] * 4, 'templates', 'pic'), __FILE__)
      PIC_SUFFIX = '.pic'

      def initialize(fh = STDOUT)
        super(PIC_TEMPLATE_DIR, PIC_SUFFIX, fh)
      end

      def start_header
        self.file_handle.puts "\"\n./\" This file was generated automagically. DO NOT EDIT!\n./\""
      end

      def header(w, h)
        @system_width = w
        @system_height = h
        super
      end

      def output(system)
        @system = system
        super unless @system.empty?
      end

    end

  end
end
