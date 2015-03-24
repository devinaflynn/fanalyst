class Payment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :allowed_user, foreign_key: :allowed_user_id, class_name: User
end
