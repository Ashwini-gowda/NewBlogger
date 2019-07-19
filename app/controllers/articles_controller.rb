class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def auto_suggest
    search_text = params[:term]
    articles = Article.search(search_text, operator: "or")
    render json: articles.as_json(:methods => [:title_with_author])
  end

  def index
    #@articles = Article.order("created_at DESC").paginate(page: params[:page], per_page: 3)
    filter = {}
    filter[:where] = {}
    query = (params[:query_text].nil? or params[:query_text].blank?) ? "*" : params[:query_text]
    filter[:match] = :text_middle

     #if can?(:manage, Article)
     if params[:query_text].present? 
      @articles = Article.search(query, filter)
    else
      @articles = Article.order("created_at DESC").paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    @comments = @article.comments
    #@sub_categories = @article.sub_categories
    #@users = @article.users
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new 
    end
  end

  def edit  
  end
 
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit 
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.' 
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :author, :content, :image, :user_id, sub_categories_attributes: [:id, :name, :category_id, :_destroy])
    end
end
