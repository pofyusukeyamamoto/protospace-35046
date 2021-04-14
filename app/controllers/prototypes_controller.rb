class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 
  before_action :move_to_index, except: [:index, :show]

 def index
  @prototypes = Prototype.all
 end

 def new
  @prototype = Prototype.new
 end

 def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user) #N+1問題も解決している  
 end

 def create
    @prototype = Prototype.new(prototype_params)
  if @prototype.save
    redirect_to root_path
  else
    render :new
  end
 end

 def edit
    @prototype = Prototype.find(params[:id])
    if user_signed_in? && current_user.id != @prototype.user_id
      redirect_to root_path
    end
 end

 def update
   @prototype = Prototype.find(params[:id])
   if @prototype.update(prototype_params)
    redirect_to prototypes_index_path
  else
    render :edit
  end
 end

 def destroy
  @prototype = Prototype.find(params[:id])
  @prototype.destroy
  redirect_to prototypes_index_path
 end

  private
 def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
 end

 def move_to_index
  unless user_signed_in?
    redirect_to action: :index
  end
 end
end