class Post < ApplicationRecord

  validates_presence_of :content

  before_create :generate_tokens

  protected

  def generate_tokens
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(32, false)
      break random_token unless Post.exists?(token: random_token)
    end
    self.uuid = loop do
      random_uuid = SecureRandom.uuid
      break random_uuid unless Post.exists?(uuid: random_uuid)
    end
  end

end