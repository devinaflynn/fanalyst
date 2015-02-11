class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :teams
  has_many :payments
  has_many :results

  def allowed?(user)
    count = payments.where(allowed_user_id: user.id).where('expires_at > ?', Time.zone.now).count
    count > 0
  end
end
