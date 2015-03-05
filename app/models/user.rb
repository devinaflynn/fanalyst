class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :teams
  has_many :payments
  has_many :results

  has_attached_file :profile_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, default_url: 'avatar.svg'
  validates_attachment_content_type :profile_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  acts_as_taggable_on :sports, :favorite_teams
  attr_accessor :sport_tags
  attr_accessor :favorite_team_tags



  # returns true if the current user payed to have access to the user profile
  def allowed?(user)
    count = payments.where(allowed_user_id: user.id).where('expires_at > ?', Time.zone.now).count
    count > 0
  end

  # Overrides the devise update_with_password method that requires a current_password.
  #
  def update_with_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)

    clean_up_passwords
    result
  end

  def current_rank
    # TODO: in the future this will need to be refactored for performance reasons
    @users = User.order(avarage_score: :desc)
    @users.map(&:id).index(self.id) + 1
  end
end
