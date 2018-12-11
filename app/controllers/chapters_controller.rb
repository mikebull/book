class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
  end

  def show
    @chapter = Chapter.find_by_slug(params[:slug])
    @comments = @chapter.comments
  end
end
