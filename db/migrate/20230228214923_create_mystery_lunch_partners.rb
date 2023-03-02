class CreateMysteryLunchPartners < ActiveRecord::Migration[6.1]
  def change
    create_table :mystery_lunch_partners do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :mystery_lunch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
