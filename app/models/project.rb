class Project < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  validates :name, presence: true
  validates :submission_date, presence: true
  validates :description, presence: true

  COLOR = ["red", "blue", "orange", "cyan"]

  FONT_SIZE = ["10", "15", "20", "25"]

  def project_picture
    image.nil? ? "no_image.png" : image.avatar.url
  end

  def creater
    user.name
  end

  def admin?(login_user)
    user == login_user
  end
end
