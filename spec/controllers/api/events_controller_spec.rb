require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  include ApiHelper

  describe '#index' do
    let(:params) { {} }
    let(:request) { get :index, params: params }

    describe 'no arguments in search' do
      before do
        15.times { create(:event) }
      end

      it 'returns the first page of events' do
        request
        expect(response).to have_http_status(:ok)
        expect(json_response.count).to eq(10)
      end

      describe 'no arguments but second page' do
        let(:params) { { page: 2 } }

        it 'returns the first page of events' do
          request
          expect(response).to have_http_status(:ok)
          expect(json_response.count).to eq(5)
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
      let(:params) { { categories: "Thriller, Comedy" } }
      let(:category1) { create(:category, name: 'Thriller') }
      let(:category2) { create(:category, name: 'Comedy') }
      let!(:event1) { create(:event, categories: [category1, category2], start_time: Time.now + 1.minute) }
      let!(:event2) { create(:event, categories: [create(:category)]) }
      let!(:event3) { create(:event, categories: [create(:category)]) }
      let!(:event4) { create(:event, categories: [create(:category), category2], start_time: Time.now + 2.minutes) }

      it 'returns events that match categories' do
        request
        expect(json_response.count).to eq(2)
        expect(json_response[0]["name"]).to eq(event1.name)
        expect(json_response[0]['categories'][0]['name']).to eq('Thriller')
        expect(json_response[0]['categories'][1]['name']).to eq('Comedy')
      end
    end
  end
end
