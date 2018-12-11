module Admin
  class ChaptersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Chapter.
    #     page(params[:page]).
    #     per(10)
    # end

    def create
      @chapter = Chapter.new admin_chapter_params
      if @chapter.save
        @chapter.update_attributes(slug: Chapter.to_slug(@chapter.title))
        ParagraphWorker.perform_async @chapter.id
        redirect_to admin_chapters_url
      else
        render action: 'new'
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Chapter.find_by!(slug: param)
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def admin_chapter_params
      params.require(:chapter).permit(:title, :body, :slug)
    end
  end
end
