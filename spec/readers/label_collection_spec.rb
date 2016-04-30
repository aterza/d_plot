require 'spec_helper'

describe DPlot::Readers::LabelCollection do

  before :example do
    @file = File.join(LABEL_FIXTURES_PATH, 'Schoenberg_Chamber_Symphony_No._1_m.336-352')
    @num_bars = 15
    @eps = 0.00001
  end

  it 'can be created with a label file' do
    expect((s = DPlot::Readers::LabelCollection.new(@file)).class).to be(DPlot::Readers::LabelCollection)
  end

  it 'returns an array of labels' do
    expect((s = DPlot::Readers::LabelCollection.new(@file)).class).to be(DPlot::Readers::LabelCollection)
    expect(s.respond_to?(:labels)).to be(true)
    expect(s.labels.kind_of?(Hash)).to be(true)
    expect(s.labels.keys.size).to eq(@num_bars)
  end

end
