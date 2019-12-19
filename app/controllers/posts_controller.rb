class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :destroy_img]
  before_action :set_games

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  # def show
  # end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        if !params[:image][:image].blank?
          # image = @post.images.new(params[:image][:image]).first_or_create
          @post.add_image(params[:image][:image])
        end
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        if !params[:image][:image].blank?
          # image = @post.images.new(params[:image][:image]).first_or_create
          @post.add_image(params[:image][:image])
        end
        format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_img
    image = Image.find(params[:img_id])
    image.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_path(@post.id), notice: "Image successfully removed" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:date, :game, :summary, :product, :review, image_attributes: [:image, :id])
    end

    def set_games
      @games = Post.all
    end
end
