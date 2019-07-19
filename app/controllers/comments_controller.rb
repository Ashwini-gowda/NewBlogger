class CommentsController < ApplicationController

  before_action  :find_commentable, :set_comment, only: [:show, :edit, :update, :destroy, :reply]


  def index
    @comments = Comment.all
  end

  def show

  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def reply
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to article_url(@article), notice: 'Reply was successfully done.'
    else
      render :new
    end
  end

  def create
    @article = Article.find(params[:article_id])
    #@comment = @commentable.comments.new(comment_params)
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to article_url(@article), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
    end

     def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
    end
end
