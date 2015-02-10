class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.text :notes
      t.decimal :score

      t.timestamps null: false
    end
  end
end
