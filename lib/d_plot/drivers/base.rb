require 'erb'

module DPlot
  module Drivers

    class PureVirtualFunction < StandardError; end

    class Base

      attr_reader :template_dir, :suffix
      attr_accessor :file_handle

      def initialize(tdir, sfx, fh = STDOUT)
        @template_dir = tdir
        @suffix = sfx
        @file_handle = fh
      end

      def start_header
        raise PureVirtualFunction, 'private virtual function start_header'
      end

      def header(w, h)
        cat_anything(build_path('header'), self.file_handle)
      end

      def trailer
        cat_anything(build_path('trailer'), self.file_handle)
      end

      def output(system)
        cat_anything(build_path('output'), self.file_handle)
      end

    private

      def build_path(what)
        File.join(self.template_dir, [what, self.suffix, '.erb'].join)
      end

      def cat_anything(path, fh)
        b = binding
        text = File.open(path, 'r').readlines.join
        out = ERB.new(text, nil, '<>').result b
        fh.print out
      end

    end

  end
end
