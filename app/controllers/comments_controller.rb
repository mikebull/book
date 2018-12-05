class CommentsController < ApplicationController
  def new
    @chapter = Chapter.find_by_slug(params[:chapter_slug])
    @comment = @chapter.comments.new(paragraph_reference: params[:paragraph_id])
  end

  def create
    @chapter = Chapter.find_by_slug(params[:chapter_slug])
    @comment = @chapter.comments.build comment_params
    if @comment.save
      redirect_to chapter_path(slug: params[:chapter_slug])
    else
      render action: 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :body, :chapter_id, :paragraph_reference)
  end
end
