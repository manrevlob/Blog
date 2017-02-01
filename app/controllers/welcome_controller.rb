class WelcomeController < ApplicationController

  # Acciones a realizar antes de llegar al controlador
  before_action :authenticate_admin!, only: [:dashboard]

  def index
  end

  def dashboard
    @articles = Article.all
  end

end
