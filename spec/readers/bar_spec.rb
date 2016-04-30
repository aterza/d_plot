require 'spec_helper'

describe DPlot::Readers::Bar do

  before :example do
    @score = DPlot::Readers::Score.new(File.join(SCORE_FIXTURES_PATH, 'etude.xml'))
  end

  it 'is created along with a score' do
    @score.systems.each { |s| s.each { |b| expect(b.kind_of?(DPlot::Readers::Bar)).to be(true) } }
  end

  it 'has a width method in millimeters' do
    expect((b = @score.systems.first.first).class).to be(DPlot::Readers::Bar)
    expect(b.respond_to?(:width)).to be(true)
  end

end

