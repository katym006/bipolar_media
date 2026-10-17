
class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.accessible_by(current_ability, :read)
                       .includes(:tags)
                       .order(published_at: :desc)
  end

  def show
    authorize! :read, @article
  end

  def new
    @article = Article.new
    authorize! :create, @article
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user

    authorize! :create, @article

    if @article.save
      redirect_to @article, notice: "Статья создана"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize! :update, @article
  end

  def update
    authorize! :update, @article

    if @article.update(article_params)
      redirect_to @article, notice: "Статья обновлена"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize! :destroy, @article
    @article.destroy!

    redirect_to articles_path, notice: "Статья удалена"
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :content_kind,
      :audience,
      :published_at
    )
  end
end
