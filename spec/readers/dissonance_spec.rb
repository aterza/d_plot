require 'spec_helper'

describe DPlot::Readers::Dissonance do

  before :example do
    @file = File.join(AUDIO_FIXTURES_PATH, 'Schoenberg_Chamber_Symphony_No._1_m.336-352.mp3')
    @eps = 0.00001
  end

  it 'can be created with an audio file' do
    expect((s = DPlot::Readers::Dissonance.new(@file)).class).to be(DPlot::Readers::Dissonance)
  end

  it 'returns an array of levels' do
    expect((s = DPlot::Readers::Dissonance.new(@file)).class).to be(DPlot::Readers::Dissonance)
    expect(s.respond_to?(:levels)).to be(true)
    expect(s.levels.kind_of?(Array)).to be(true)
    expect(s.levels.empty?).to be(false)
  end

  it 'is able to return a portion of the array of levels on a time range' do
    expect((s = DPlot::Readers::Dissonance.new(@file)).class).to be(DPlot::Readers::Dissonance)
    expect((r = s.range(10.0, 11.0)).kind_of?(Array)).to be(true)
    expect(r.size > 0).to be(true)
    expect(r.size).to eq((44100.0/1024.0).floor)
  end

end

