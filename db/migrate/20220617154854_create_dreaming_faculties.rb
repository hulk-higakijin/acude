class CreateDreamingFaculties < ActiveRecord::Migration[7.0]
  def change
    create_table :dreaming_faculties do |t|
      t.references :faculty, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
