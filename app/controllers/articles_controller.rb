class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article was saved successfully."
      redirect_to @article
    else
      flash.now[:alert] = "There was an error saving this article. Please try again."
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)

    if @article.save
      flash[:notice] = "Article was updated successfully."
      redirect_to [@article]
    else
      flash.now[:alert] = "There was an error saving this article. Please try again."
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "\"#{@article.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting this article."
      render :show
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end


end
