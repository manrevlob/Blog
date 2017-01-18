class ArticlesController < ApplicationController

  # Acciones a realizar antes de llegar al controlador
  before_action :authenticate_user!, except: [:show, :index]
  before_action :article_set, except: [:index, :new, :create]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  def show
    @article.update_visits_count
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
    @article.destroy
    redirect_to articles_path
  end

  #GET "/articles/:id/edit" edit
  def edit
  end

  #PUT /articles/:id
  def update

    @article.update(article_params)
    if @article.valid? #True pasa todas las validaciones, False no las pasa
      @article.save
      redirect_to @article
    else
      render :new
    end

  end

  private

  def article_set
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :visits_count)
  end

end