class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.text :notes
      t.decimal :score
      t.references :team
      t.attachment :image

      t.timestamps null: false
    end

    add_index(:results, :team_id, unique: true)

    add_column(:users, :avarage_sum_score, :decimal, default: 0)
    add_column(:users, :avarage_count_score, :integer, default: 0)
    add_column(:users, :avarage_score, :decimal, default: 0)
  end
end
