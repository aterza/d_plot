require 'spec_helper'

describe DPlot::Drivers::Pic do

  before :example do
    @examples = [ 'chamber', 'marcia', 'etude' ]
    @methods = [:header, :output ]
    @file_handle = StringIO.new
  end

  it 'can be created with no arguments' do
    expect((p = DPlot::Drivers::Pic.new).class).to be(DPlot::Drivers::Pic)
  end

  it 'has the methods header, trailer and output' do
    expect((p = DPlot::Drivers::Pic.new).class).to be(DPlot::Drivers::Pic)
    @methods.each { |m| expect(p.respond_to?(m)).to be(true) }
  end

  it 'can produce output' do
    basedir = File.join(AGGREGATE_FIXTURES_PATH, 'etude')
    expect((a = DPlot::Models::Aggregator.new('etude', 'basedir' => basedir, 'outfile_handle' => @file_handle)).class).to be(DPlot::Models::Aggregator)
    expect((p = DPlot::Drivers::Pic.new(@file_handle)).class).to be(DPlot::Drivers::Pic)
    last_size = 0
    p.header(a.systems.first.width, a.systems.first.height)
    expect(@file_handle.size > last_size).to be(true)
    last_size = @file_handle.size
    a.systems.each do
      |sys|
      unless sys.empty?
        p.output(sys)
        expect(@file_handle.size > last_size).to be(true)
        last_size = @file_handle.size
      end
    end
    p.trailer
    expect(@file_handle.size > last_size).to be(true)
  end

end
