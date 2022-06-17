class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.text :introduction
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
