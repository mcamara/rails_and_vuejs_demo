class Api::EventsController < ApplicationController
  def index
    @events = Events::EventSearchService
              .new(event_params)
              .search
              .includes(:categories, :city)
              .page(params[:page])
    render json: @events, each_serializer: Api::EventSerializer
  end

  private

  def event_params
    params.permit(
      :name,
      :categories,
      :city,
      :start_date
    )
  end
end
