require 'spec_helper'

describe DPlot::Readers::Score do

  before :example do
    @examples =
    {
      'chamber' => { num_bars: 4, num_systems: 1 },
      'marcia' => { num_bars: 12, num_systems: 2 },
      'etude' => { num_bars: 13, num_systems: 7 },
    }
    @file = File.join(SCORE_FIXTURES_PATH, 'Schoenberg_Chamber_Symphony_No._1_m.336-352.xml')
    @num_bars = 15
    @eps = 0.00001
  end

  it 'can be created with an XML score' do
    expect((s = DPlot::Readers::Score.new(@file)).class).to be(DPlot::Readers::Score)
  end

  it 'has a collection of systems' do
    @examples.each do
      |name, attrs|
      expect((s = DPlot::Readers::Score.new(File.join(SCORE_FIXTURES_PATH, name + '.xml'))).class).to be(DPlot::Readers::Score)
      expect(s.respond_to?(:systems)).to be(true)
      expect(s.systems.size).to eq(attrs[:num_systems]), "#{name}: #{s.systems.size} <=> #{attrs[:num_systems]}"
      res = 0; s.systems.each { |ss| res += ss.size }
      expect(res).to eq(attrs[:num_bars]), "#{name}: #{res} <=> #{attrs[:num_bars]}"
    end
  end

  it 'has a num_bars method aliased as size' do
    expect((s = DPlot::Readers::Score.new(@file)).class).to be(DPlot::Readers::Score)
    [:num_bars, :size].each { |m| expect(s.respond_to?(m)).to be(true) }
    expect(s.num_bars).to eq(s.size)
  end
end
