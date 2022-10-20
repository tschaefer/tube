# frozen_string_literal: true

require 'spec_helper'

require 'tube'

RSpec.describe Tube do
  let(:categories) { [] }
  let(:tube) do
    VCR.use_cassette('watch', record: :new_episodes) do
      described_class.watch(categories)
    end
  end

  describe '#watch' do
    context 'when category is unknown' do
      let(:categories) { %w[unknown] }

      it 'raises an error' do
        expect { tube }.to raise_error(ArgumentError)
      end
    end

    context 'when no category is specified' do
      it 'returns an object', :aggregate_failures do
        expect(tube).to be_an_instance_of(Module)
        expect(tube.shows).to be_an(Array)
      end
    end

    context 'when category is specified' do
      let(:categories) { %w[sports main] }

      it 'returns an object', :aggregate_failures do
        expect(tube).to be_an_instance_of(Module)
        expect(tube.shows).to be_an(Array)
      end
    end
  end

  describe '#to_json' do
    it 'returns show schedule in JSON format' do
      expect { JSON.parse(tube.to_json) }.not_to raise_error
    end
  end

  describe '#to_table' do
    it 'returns table with header' do
      expect(tube.to_table).to match(/CHANNEL\s+SHOW\s+STARTED/)
    end
  end

  describe '#schedule' do
    context 'when format is unknown' do
      it 'raises error' do
        expect { tube.schedule('unknown') }.to raise_error(ArgumentError)
      end
    end

    context 'when format is known' do
      it 'returns result', :aggregate_failures do
        expect(tube.schedule('json')).not_to be nil?
        expect(tube.schedule('table')).not_to be nil?
      end
    end
  end
end
