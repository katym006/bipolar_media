class MoodEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def index
    @mood_entries = @profile.mood_entries.order(entry_date: :desc)
  end

  def new
    @mood_entry = @profile.mood_entries.new(entry_date: Date.current)
  end

  def create
    @mood_entry = @profile.mood_entries.new(mood_entry_params)
    if @mood_entry.save
      redirect_to mood_entries_path, notice: "Запись сохранена"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_profile
    @profile = current_user.profile ||
               current_user.create_profile!(display_name: current_user.name.presence || current_user.email.split("@").first)
  end

  def mood_entry_params
    params.require(:mood_entry).permit(:entry_date, :mood_level, :energy_level, :sleep_hours, :emotions, :note)
  end
end
