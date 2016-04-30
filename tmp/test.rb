$: << File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
$: << File.expand_path(File.join(['..'] * 3, 'essentia-ruby', 'lib'), __FILE__)

require 'd_plot'

examples = { 'chamber' => 4, 'marcia' => 12, 'etude' => 12 }

OUTDIR = File.expand_path('..', __FILE__)

mTdB = -35 # Magnitude Threshold
mT = 10**(mTdB/20.0)

examples.each do
  |name, val|
  basedir = File.expand_path(File.join(['..'] * 2, 'spec', 'fixtures', 'aggregates', name), __FILE__)
  a = DPlot::Models::Aggregator.new(name, 'basedir' => basedir, 'outdir' => OUTDIR, 'magnitudeThreshold' => mT)
  a.plot
end
