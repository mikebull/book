class AddSlugToChapter < ActiveRecord::Migration[5.1]
  def change
    add_column :chapters, :slug, :string
  end
end
