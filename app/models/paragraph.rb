class Paragraph < ApplicationRecord
  belongs_to :chapter

  def to_param
    paragraph_reference
  end
end
