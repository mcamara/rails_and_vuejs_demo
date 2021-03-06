require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  include ApiHelper

  describe '#index' do
    let(:params) { {} }
    let(:request) { get :index, params: params }

    describe 'no arguments in search' do
      before do
        35.times { create(:event) }
      end

      it 'returns the first page of events' do
        request
        expect(response).to have_http_status(:ok)
        expect(json_response.count).to eq(24)
      end

      describe 'no arguments but second page' do
        let(:params) { { page: 2 } }

        it 'returns the first page of events' do
          request
          expect(response).to have_http_status(:ok)
          expect(json_response.count).to eq(11)
        end
      end
    end

    describe 'searching by name' do
      let(:params) { { name: 'name' } }
      let!(:event1) { create(:event, name: 'name not really original', start_time: Time.now + 1.minute) }
      let!(:event2) { create(:event, name: 'another event') }
      let!(:event3) { create(:event, name: 'event 3') }
      let!(:event4) { create(:event, name: 'another event with no name', start_time: Time.now + 2.minutes) }

      it 'returns events that match the name' do
        request
        expect(json_response.count).to eq(2)
        expect(json_response[0]["name"]).to eq(event1.name)
      end
    end

    describe 'searching by city' do
      let(:params) { { city: 'Winterfell' } }
      let(:city) { create(:city, name: 'Winterfell') }
      let!(:event1) { create(:event, city: city, start_time: Time.now + 1.minute) }
      let!(:event2) { create(:event, city: create(:city)) }
      let!(:event3) { create(:event, city: create(:city)) }
      let!(:event4) { create(:event, city: city, start_time: Time.now + 2.minutes) }

      it 'returns events that match the name of the city' do
        request
        expect(json_response.count).to eq(2)
        expect(json_response[0]["name"]).to eq(event1.name)
        expect(json_response[0].dig('city', 'name')).to eq('Winterfell')
      end
    end

    describe 'searching by category' do
      let(:category1) { create(:category, name: 'Thriller') }
      let(:category2) { create(:category, name: 'Comedy') }
      let(:params) { { categories: [category1.id, category2.id] } }
      let!(:event1) { create(:event, categories: [category1, category2], start_time: Time.now + 1.minute) }
      let!(:event2) { create(:event, categories: [create(:category)]) }
      let!(:event3) { create(:event, categories: [create(:category)]) }
      let!(:event4) { create(:event, categories: [create(:category), category2], start_time: Time.now + 2.minutes) }

      it 'returns events that match categories' do
        request
        expect(json_response.count).to eq(2)
        expect(json_response[0]["name"]).to eq(event1.name)
        expect(json_response[0]['categories'].map { |cat| cat['name'] }).to eq(['Thriller', 'Comedy'])
      end
    end

    describe 'searching by date' do
      let(:params) { { start_time: (Time.now + 2.days).strftime("%Y-%m-%d") } }
      let!(:event1) { create(:event, start_time: Time.now + 1.day) }
      let!(:event2) { create(:event, start_time: Time.now + 3.days) }

      it 'returns events that match categories' do
        request
        expect(json_response.count).to eq(1)
        expect(json_response[0]["name"]).to eq(event2.name)
      end
    end
  end
end
