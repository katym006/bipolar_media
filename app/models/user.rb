class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_one :profile, dependent: :destroy
has_many :test_attempts, dependent: :destroy
has_many :articles, foreign_key: :author_id, inverse_of: :author, dependent: :nullify

enum :role, {
    new: "new",
    long: "long",
    relative: "relative",
    curious: "curious"
}, prefix: true, validate: true

     enum :access_role, {
    reader: "reader",
    author: "author",
    editor: "editor",
  admin: "admin"
}, prefix: true, validate: true
end
