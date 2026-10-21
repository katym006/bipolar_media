module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!

    private

    def require_admin!
      return if current_user&.access_role_admin?

      redirect_to root_path, alert: "Доступ разрешён только администраторам."
    end
  end
end
