class CreateProfessorFaculities < ActiveRecord::Migration[7.0]
  def change
    create_table :professor_faculities do |t|
      t.references :professor, null: false, foreign_key: true
      t.references :faculty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
