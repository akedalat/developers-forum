class CommentsController < ApplicationController
  before_action :authorized
  skip_before_action :authorized, only: [:index, :show]
  #before_action :admin_authorized, only: [:new, :create, :edit, :update, :destroy]
  #before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.user != current_user
      return head(:forbidden)
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment))
    @comment.content = params[:comment][:content]
    @comment.user_id = current_user.id if current_user
    if @comment.content.empty?
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Reply NOT created. Content cannot be empty!' }
        format.json { head :no_content }
      end

      else
        @comment.save
      redirect_to post_path(@post)
      end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update(params[:comment].permit(:comment))
    @comment.content = params[:comment][:content]
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_comment
    #   @comment = Comment.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
