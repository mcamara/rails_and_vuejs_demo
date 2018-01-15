require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#start_time_is_in_future' do
    let(:event) { build(:event, start_time: Time.zone.yesterday) }
    before { event.valid? }

    it 'should show an error' do
      expect(event.errors.messages[:start_time]).to eq(['The event should start in the future'])
    end

    it 'should not be valid' do
      expect(event.valid?).to be_falsey
    end
  end

  describe '#end_time_after_start_time' do
    let(:event) { build(:event, start_time: Time.zone.tomorrow, end_time: Time.zone.now + 1.minute) }
    before { event.valid? }

    it 'should show an error' do
      expect(event.errors.messages[:end_time]).to eq(['End time cannot be before the start time'])
    end

    it 'should not be valid' do
      expect(event.valid?).to be_falsey
    end
  end
end
