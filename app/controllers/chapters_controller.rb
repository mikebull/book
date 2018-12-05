class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
  end

  def show
    @chapter = Chapter.find_by_slug(params[:slug])
    @comments = @chapter.comments
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new chapter_params
    if @chapter.save
      @chapter.update_attributes(slug: Chapter.to_slug(@chapter.title))
      redirect_to chapters_path
    else
      render action: 'new'
    end
  end

  def edit
    @chapter = Chapter.find_by_slug(params[:slug])
  end

  def update
    @chapter = Chapter.find_by_slug(params[:slug])
    if @chapter.update chapter_params
      redirect_to chapter_path
    else
      render action: :edit
    end
  end

  def destroy

  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :body, :slug)
  end
end
