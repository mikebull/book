class AddParagraphReferenceToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :paragraph_reference, :string
  end
end
