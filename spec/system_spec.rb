require 'spec_helper'

describe DPlot::System do

  before :example do
    @score = DPlot::Readers::Score.new(File.join(SCORE_FIXTURES_PATH, 'etude.xml'))
  end

  it 'is created along with a score' do
    @score.systems.each { |s| expect(s.kind_of?(DPlot::System)).to be(true) }
  end

  it 'has a collection of bars' do
    expect((s = @score.systems.first).size).to be > 0
    s.each { |b| expect(b.class).to be(DPlot::Readers::Bar) }
  end

  it 'has a width method which is the sum of all widths' do
    expect((s = @score.systems.first).size).to be > 0
    w = 0
    s.each { |b| w += b.width }
    expect(s.width).to eq(w)
  end

end
