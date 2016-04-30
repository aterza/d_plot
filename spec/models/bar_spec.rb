require 'spec_helper'

describe DPlot::Models::Bar do

  before :example do
    @levels = [ DPlot::Readers::Level.new(5.0, 0.0), DPlot::Readers::Level.new(5.25, 0.49), DPlot::Readers::Level.new(5.5, 0.27) ]
    @args = { number: 23, start_time: 5.0, end_time: 5.5, dissonance: @levels, width: 8.52, start_pos: 7.2 }
    @eps = 0.0001
  end

  it 'can be created with a hash' do
    expect((s = DPlot::Models::Bar.new(@args)).class).to be(DPlot::Models::Bar)
  end

  it 'calculates spaces properly' do
    expect((s = DPlot::Models::Bar.new(@args)).class).to be(DPlot::Models::Bar)
    expect(s.end_pos).to be_within(@eps).of(@args[:start_pos] + @args[:width])
    s.dissonance.each_with_index do
      |d, idx|
      where = s.start_pos + ((d.time - s.start_time) * s.conv_width)
      expect(s.dissonance_pos(idx)).to be_within(@eps).of(where)
    end
  end

  it 'calculates spaces properly on a system' do
    expect((sys = DPlot::System.new).class).to be(DPlot::System)
    sys.start_pos = 4.0
    @args.update(start_pos: sys.start_pos)
    expect((b = DPlot::Models::Bar.new(@args)).class).to be(DPlot::Models::Bar)
    expect(b.end_pos).to be_within(@eps).of(@args[:start_pos] + @args[:width])
    sys << b
    sys.each do
      |bar|
      bar.dissonance.each_with_index do
        |d, idx|
        where = bar.start_pos + ((d.time - bar.start_time) * bar.conv_width)
        expect(bar.dissonance_pos(idx)).to be_within(@eps).of(where)
      end
    end

  end

end
