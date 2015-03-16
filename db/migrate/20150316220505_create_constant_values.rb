class CreateConstantValues < ActiveRecord::Migration
  def change
    create_table :constant_values do |t|
      t.decimal :fan_duel_median_score

      t.timestamps null: false
    end

    ConstantValue.create
  end
end
