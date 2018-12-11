require "administrate/base_dashboard"

class ParagraphDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    chapter: Field::BelongsTo,
    paragraph_reference: Field::String,
    paragraph: Field::Text,
    node_type: Field::String,
    node_position: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :chapter,
    :paragraph_reference,
    :paragraph,
    :node_type,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :chapter,
    :paragraph_reference,
    :paragraph,
    :node_type,
    :node_position,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :chapter,
    :paragraph_reference,
    :paragraph,
    :node_type,
    :node_position,
  ].freeze

  # Overwrite this method to customize how paragraphs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(paragraph)
  #   "Paragraph ##{paragraph.id}"
  # end
end
