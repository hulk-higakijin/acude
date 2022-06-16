class CreateUniversities < ActiveRecord::Migration[7.0]
  def change
    create_table :universities do |t|
      t.string :name, null: false
      t.text :introduction
      t.references :prefecture, null: false, foreign_key: true
      t.text :url
      t.text :note
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
