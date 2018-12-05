class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.timestamps
      t.references :chapter, foreign_key: true
    end
  end
end
