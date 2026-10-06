class SpecialistsController < ApplicationController
  def index
    @specialists = Specialist.includes(:city).order(rating: :desc)
    @specialists = @specialists.where(city_id: params[:city_id]) if params[:city_id].present?
    @cities = City.order(:name)
  end
end
