module Paginatable
  extend ActiveSupport::Concern

  private

  def paginate(relation, per_page: 10)
    @page = params[:page].to_i
    @page = 1 unless @page.positive?

    @per_page = per_page
    @total_count = relation.count
    @total_pages = [(@total_count.to_f / @per_page).ceil, 1].max
    @page = @total_pages if @page > @total_pages

    relation.offset((@page - 1) * @per_page).limit(@per_page)
  end
end
