class CommentsController < ApplicationController

 def create
  #@prototype = Prototype.new(prototype_params)
  @comment = Comment.new(comment_params)
  if @comment.save
    redirect_to prototype_path(@comment.prototype) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
  else
    @prototype = @comment.prototype
    @comments = @prototype.comments
    render prototypes/show # views/tweets/show.html.erbのファイルを参照しています。
  end
 end

 def show
  @comment = Comment.new
  @comment = @prototype.comments.include(:user)
 end

private
 def comment_params
    params.require(:comment).permit(:text).merge(user_id:current_user.id, prototype_id: params[:prototype_id])
 end

end
