class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created succesfully."
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit 
    end

  end

  def destroy
    
    @article.destroy

    redirect_to articles_path
  end


  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end



end
