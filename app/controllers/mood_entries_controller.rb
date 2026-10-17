class MoodEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_mood_entry, only: %i[show edit update destroy]

  def index
    @mood_entries = @profile.mood_entries.order(entry_date: :desc)
  end

  def show
    authorize! :read, @mood_entry
  end

  def new
    @mood_entry = @profile.mood_entries.new(entry_date: Date.current)
    authorize! :create, @mood_entry
  end

  def create
    @mood_entry = @profile.mood_entries.new(mood_entry_params)
    authorize! :create, @mood_entry

    if @mood_entry.save
      redirect_to @mood_entry, notice: "Запись сохранена"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @mood_entry
  end

  def update
    authorize! :update, @mood_entry

    if @mood_entry.update(mood_entry_params)
      redirect_to @mood_entry, notice: "Запись обновлена"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @mood_entry
    @mood_entry.destroy!
    redirect_to mood_entries_path, notice: "Запись удалена"
  end

  private

  def set_profile
    @profile = current_user.profile ||
               current_user.create_profile!(
                 display_name: current_user.name.presence ||
                               current_user.email.split("@").first
               )
  end

  # Scope lookup to the signed-in user's profile to prevent IDOR.
  def set_mood_entry
    @mood_entry = @profile.mood_entries.find(params[:id])
  end

  def mood_entry_params
    params.require(:mood_entry).permit(
      :entry_date, :mood_level, :energy_level,
      :sleep_hours, :emotions, :note
    )
  end
end
