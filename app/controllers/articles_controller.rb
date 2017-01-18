class ArticlesController < ApplicationController

  before_action :validate_user, except: [:show, :index]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  #GET /articles/new
  def new
    @article = Article.new
  end

  #POST /articles
  def create
    # @article = Article.new(title: params[:article][:title],
    #                        body: params[:article][:body],
    #                        visits_count: 0)
    @article = current_user.articles.new(article_params)

    if @article.valid? #True pasa todas las validaciones, False no las pasa
      @article.save
      redirect_to @article
    else
      render :new
    end
  end

  #DELETE "/articles/:id"
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  #GET "/articles/:id/edit" edit
  def edit
    @article = Article.find(params[:id])
  end

  #PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.valid? #True pasa todas las validaciones, False no las pasa
      @article.save
      redirect_to @article
    else
      render :new
    end

  end

  private

  def validate_user
    redirect_to new_user_session_path, notice: "Necesita iniciar sesión"
  end

  def article_params
    params.require(:article).permit(:title, :body, :visits_count)
  end

end