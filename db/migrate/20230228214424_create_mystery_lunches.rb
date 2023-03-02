class CreateMysteryLunches < ActiveRecord::Migration[6.1]
  def change
    create_table :mystery_lunches do |t|

      t.timestamps
    end
  end
end
