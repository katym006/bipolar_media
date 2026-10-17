class SpecialistsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_specialist, only: %i[show edit update destroy]

  def index
    @specialists = Specialist.includes(:city).order(rating: :desc)
    @specialists = @specialists.where(city_id: params[:city_id]) if params[:city_id].present?
    @cities = City.order(:name)
  end

  def show
  end

  def new
    @specialist = Specialist.new
    @cities = City.order(:name)
    authorize! :create, @specialist
  end

  def create
    @specialist = Specialist.new(specialist_params)
    authorize! :create, @specialist

    if @specialist.save
      redirect_to @specialist, notice: "Специалист добавлен"
    else
      @cities = City.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cities = City.order(:name)
    authorize! :update, @specialist
  end

  def update
    authorize! :update, @specialist

    if @specialist.update(specialist_params)
      redirect_to @specialist, notice: "Данные специалиста обновлены"
    else
      @cities = City.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @specialist
    @specialist.destroy!
    redirect_to specialists_path, notice: "Специалист удалён"
  end

  private

  def set_specialist
    @specialist = Specialist.find(params[:id])
  end

  def specialist_params
    params.require(:specialist).permit(:full_name, :specialty, :city_id, :contacts, :rating)
  end
end
