$: << File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
$: << File.expand_path(File.join(['..'] * 3, 'essentia-ruby', 'lib'), __FILE__)

require 'd_plot'

examples = { 'chamber' => 4, 'marcia' => 12, 'etude' => 12 }

OUTDIR = File.expand_path('..', __FILE__)

examples.each do
  |name, val|
  basedir = File.expand_path(File.join(['..'] * 2, 'spec', 'fixtures', 'aggregates', name), __FILE__)
  a = DPlot::Models::Aggregator.new(name, 'basedir' => basedir, 'outdir' => OUTDIR, 'magnitudeThreshold' => 0.01)
  a.plot
end
