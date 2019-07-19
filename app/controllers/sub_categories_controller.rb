class SubCategoriesController < ApplicationController
  before_action :set_sub_category, only: [:show, :edit, :update, :destroy]

  def index
    @sub_categories = SubCategory.all
  end

  def show
    @article = Article.find(params[:article_id])
    @category = @sub_category.category  
    @sub_categories = @article.sub_categories
  end

  def new
    @sub_category = SubCategory.new
  end

  def edit
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    if @sub_category.save
      redirect_to @sub_category, notice: 'Sub category was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @sub_category.update(sub_category_params)
      redirect_to @sub_category, notice: 'Sub category was successfully updated.' 
    else
      render :edit 
    end
  end

  def destroy
    @sub_category.destroy
    redirect_to sub_categories_url, notice: 'Sub category was successfully destroyed.' 
  end

  private
    def set_sub_category
      @sub_category = SubCategory.find(params[:id])
    end

    def sub_category_params
      params.require(:sub_category).permit(:name, :article_id)
    end
end
