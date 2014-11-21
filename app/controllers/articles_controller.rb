class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.paginate(:page => params[:page])
    puts @articles
  end

  def my
    @articles = current_user.articles.paginate(:page => params[:page])
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    if @article.user != current_user
      redirect_to @article, notice: 'Permission denied.'
    end
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user= current_user

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.user != current_user
      redirect_to @article, notice: 'Permission denied.'
    else
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /articles/1
  def destroy
    if @article.user != current_user
      redirect_to @article, notice: 'Permission denied.'
    end
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
