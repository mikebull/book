module Admin
  class ParagraphsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Paragraph.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Paragraph.find_by!(paragraph_reference: param)
    end

    def requested_resource
      @requested_resource ||= find_resource(params[:paragraph_reference]).tap do |resource|
        authorize_resource(resource)
      end
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
