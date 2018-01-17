require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :controller do
  include ApiHelper

  describe '#index' do
    let(:request) { get :index }
    before do
      12.times { create(:category) }
    end

    it 'returns all categories' do
      request
      expect(response).to have_http_status(:ok)
      expect(json_response.count).to eq(12)
    end
  end
end
