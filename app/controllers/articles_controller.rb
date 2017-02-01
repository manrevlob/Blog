class ArticlesController < ApplicationController

  # Acciones a realizar antes de llegar al controlador
  before_action :authenticate_user!, except: [:show, :index]
  before_action :article_set, except: [:index, :new, :create]
  before_action :authenticate_editor!, only: [:new, :create, :update]
  before_action :authenticate_admin!, only: [:destroy, :publish]

  # GET /articles
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).publicados.ultimos
  end

  # GET /articles/:id
  def show
    @article.update_visits_count
    @comment = Comment.new
  end

  #GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all
  end

  #POST /articles
  def create
    # @article = Article.new(title: params[:article][:title],
    #                        body: params[:article][:body])
    @article = current_user.articles.new(article_params)
    @article.categories = params[:categories]

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

  def publish
    @article.publish!
    redirect_to articles_path
  end

  private

  def article_set
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def article_params
    params.require(:article).permit(:title, :body, :cover, :categories)
  end

end