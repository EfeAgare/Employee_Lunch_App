class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.references :department, null: false, foreign_key: true
      t.string :photo
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :employees, :deleted_at
  end
end
