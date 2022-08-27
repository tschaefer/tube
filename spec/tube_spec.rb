# frozen_string_literal: true

require 'spec_helper'

require 'tube'

RSpec.describe Tube do
  describe '#watch' do
    context 'when category is unknown' do
      it 'raises an error' do
        expect { described_class.watch(%w[unknown]) }.to raise_error(ArgumentError)
      end
    end

    context 'when no category is specified' do
      it 'returns an object' do
        tube = described_class.watch

        expect(tube).to be_an_instance_of(Module)
        expect(tube.shows).to be_an(Array)
      end
    end

    context 'when category is specified' do
      it 'returns an object' do
        tube = described_class.watch(%w[sports main])

        expect(tube).to be_an_instance_of(Module)
        expect(tube.shows).to be_an(Array)
      end
    end
  end

  describe '#to_json' do
    it 'returns show schedule in JSON format' do
      json = described_class.watch.to_json

      expect { JSON.parse(json) }.not_to raise_error
    end
  end

  describe '#to_table' do
    it 'returns table with header' do
      expect(described_class.watch.to_table).to match(/CHANNEL\s+SHOW\s+STARTED/)
    end
  end

  describe '#schedule' do
    context 'when format is unknown' do
      it 'raises error' do
        expect { described_class.watch.schedule('unknown') }.to raise_error(ArgumentError)
      end
    end

    context 'when format is known' do
      it 'returns result' do
        expect(described_class.watch.schedule('json')).not_to be nil?
        expect(described_class.watch.schedule('table')).not_to be nil?
      end
    end
  end
end
