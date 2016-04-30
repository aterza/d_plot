require 'spec_helper'

describe DPlot::Models::Aggregator do

  before :example do
    @examples = { 'chamber' => 4, 'marcia' => 12, 'etude' => 12 }
    @out_fh = StringIO.new
  end

  it 'can be created with standard arguments' do
    @examples.keys.each do
      |e|
      basedir = File.join(AGGREGATE_FIXTURES_PATH, e)
      expect((s = DPlot::Models::Aggregator.new(e, 'basedir' => basedir)).class).to be(DPlot::Models::Aggregator)
    end
  end

  it 'does plot to its output' do
    @examples.each do
      |e, n_bars|
      basedir = File.join(AGGREGATE_FIXTURES_PATH, e)
      expect((s = DPlot::Models::Aggregator.new(e, 'basedir' => basedir, 'outfile_handle' => @out_fh)).class).to be(DPlot::Models::Aggregator)
      res = 0
      s.systems.each { |ss| res += ss.size }
      expect(res).to eq(n_bars), "#{e}: #{res} <=> #{n_bars}"
      s.plot
      expect(@out_fh.size).to be > 0
    end
  end

  it 'has systems and bars that advance in respect to time and space' do
    @examples.each do
      |e, n_bars|
      basedir = File.join(AGGREGATE_FIXTURES_PATH, e)
      expect((a = DPlot::Models::Aggregator.new(e, 'basedir' => basedir, 'outfile_handle' => @out_fh)).class).to be(DPlot::Models::Aggregator)
      a.systems do
        |sys|
        last_start_pos = 0.0
        sys.each do
          |bar|
          expect(bar.start_pos).to be >= last_start_pos
          last_start_pos = bar.start_pos + width
        end
      end
    end
  end

end
