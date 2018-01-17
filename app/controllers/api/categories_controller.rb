class Api::CategoriesController < ApplicationController
  def index
    render json: Category.all, each_serializer: Api::CategorySerializer
  end
end
