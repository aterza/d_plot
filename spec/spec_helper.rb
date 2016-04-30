require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.expand_path(File.join(['..'] * 3, 'essentia-ruby', 'lib'), __FILE__)
require 'd_plot'
require 'byebug'

FIXTURES_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
SCORE_FIXTURES_PATH = File.join(FIXTURES_PATH, 'scores')
LABEL_FIXTURES_PATH = File.join(FIXTURES_PATH, 'labels')
AUDIO_FIXTURES_PATH = File.join(FIXTURES_PATH, 'audio')
AGGREGATE_FIXTURES_PATH = File.join(FIXTURES_PATH, 'aggregates')
