class CreateParagraphs < ActiveRecord::Migration[5.1]
  def change
    create_table :paragraphs do |t|
      t.string :paragraph_reference
      t.text :paragraph
      t.string :node_type
      t.integer :node_position
      t.references :chapter, foreign_key: true

      t.timestamps
    end
  end
end
