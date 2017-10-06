require_relative 'email_validator'

class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true, allow_blank: false, email: true

  def to_token_payload
    { sub: id, email: email }
  end
end
