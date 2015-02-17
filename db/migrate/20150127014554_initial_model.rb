class InitialModel < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.decimal :price, default: 0
      t.string :username
      t.string :stripe_customer_id, default: nil

      t.decimal :avarage_sum_score, default: 0
      t.integer :avarage_count_score, default: 0
      t.decimal :avarage_score, default: 0

      #
      # Devise
      #

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    create_table :teams do |t|
      t.text :notes
      t.attachment :image
      t.string :event

      t.references :user, index: true

      t.timestamps null: false
    end

    create_table :results do |t|
      t.text :notes
      t.decimal :score
      t.references :team
      t.attachment :image

      t.timestamps null: false
    end

    add_index(:results, :team_id, unique: true)

    create_table :payments do |t|
      t.references :user, index: true
      t.integer :allowed_user_id, index: true

      t.decimal :value
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
