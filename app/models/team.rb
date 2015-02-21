class Team < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "150x150>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  belongs_to :user
  has_one :result, dependent: :destroy

  def create_or_update_result(params)
    if result
      previous_score = result.score

      if result.update(params)
        user.avarage_sum_score+= (result.score - previous_score)
        user.avarage_score = user.avarage_sum_score / user.avarage_count_score
        user.save
      else
        return false
      end
    else
      # creates a new result
      result = Result.new(params)
      result.team = self
      if result.save
        user.avarage_sum_score+= result.score
        user.avarage_count_score+= 1
        user.avarage_score = user.avarage_sum_score / user.avarage_count_score
        user.save
      else
        return false
      end
    end

    true
  end
end
