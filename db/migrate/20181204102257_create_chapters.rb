class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :body
      t.text :description

      t.timestamps
    end
  end
end
