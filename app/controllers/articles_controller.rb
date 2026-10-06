class ArticlesController < ApplicationController
  def index
    @articles = Article.published.includes(:tags).order(published_at: :desc)
    @articles = @articles.where(audience: [ params[:audience], "both" ]) if params[:audience].present?
    @articles = @articles.where(content_kind: params[:kind]) if params[:kind].present?
  end

  def show
    @article = Article.published.find(params[:id])
  end
end
