class AddPayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.integer :allowed_user_id

      t.decimal :value
      t.datetime :expires_at

      t.timestamps null: false
    end

    add_index(:payments, :allowed_user_id)
  end
end
