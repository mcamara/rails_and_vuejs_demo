require 'rails_helper'

RSpec.describe Events::EventSearchService do
  let(:service) { Events::EventSearchService.new(args) }
  let(:args) { {} }

  describe '#search' do
    describe 'no arguments in search' do
      before do
        10.times { create(:event) }
      end

      it 'returns all evetnts' do
        expect(service.search.count).to eq(10)
      end

      it 'returns events sorted by start date' do
        times = Event.all.pluck(:start_time).sort
        expect(service.search.pluck(:start_time)).to eq(times)
      end
    end

    describe 'search by name' do
      let(:args) { { name: 'name' } }
      let(:event1) { create(:event, name: 'name not really original', start_time: Time.now + 1.minute) }
      let(:event2) { create(:event, name: 'another event') }
      let(:event3) { create(:event, name: 'event 3') }
      let(:event4) { create(:event, name: 'another event with no name', start_time: Time.now + 2.minutes) }

      it 'returns events that match the name' do
        expect(service.search).to eq([event1, event4])
      end
    end

    describe 'search by city' do
      let(:args) { { city: 'Winterfell' } }
      let(:city) { create(:city, name: 'Winterfell') }
      let(:event1) { create(:event, city: city, start_time: Time.now + 1.minute) }
      let(:event2) { create(:event, city: create(:city)) }
      let(:event3) { create(:event, city: create(:city)) }
      let(:event4) { create(:event, city: city, start_time: Time.now + 2.minutes) }

      it 'returns events that match the city' do
        expect(service.search).to eq([event1, event4])
      end
    end

    describe 'search by category' do
      let(:args) { { categories: "Thriller, Comedy"} }
      let(:category1) { create(:category, name: 'Thriller') }
      let(:category2) { create(:category, name: 'Comedy') }
      let(:event1) { create(:event, categories: [category1, create(:category)], start_time: Time.now + 1.minute) }
      let(:event2) { create(:event, categories: [create(:category)]) }
      let(:event3) { create(:event, categories: [create(:category)]) }
      let(:event4) { create(:event, categories: [create(:category), category2], start_time: Time.now + 2.minutes) }

      it 'returns events that match categories' do
        expect(service.search).to eq([event1, event4])
      end
    end

    describe 'search by start time' do
      let(:args) { { start_time: Time.zone.now + 2.days } }
      let(:event1) { create(:event, start_time: Time.now + 3.days) }
      let(:event2) { create(:event, start_time: Time.now + 1.day) }
      let(:event3) { create(:event, start_time: Time.now + 30.minute) }
      let(:event4) { create(:event, start_time: Time.now + 4.days) }

      it 'returns events that starts later than the time given' do
        expect(service.search).to eq([event1, event4])
      end
    end
  end
end
