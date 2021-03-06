class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendships", foreign_key: "friend_id", dependent: :destroy

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:friend)
  end

  def pending_friend_requests_to
    self.friendships.where(state: "pending")
  end

  def pending_friend_requests_from
    self.inverse_friendships.where(state: "pending")
  end

  def request_friendship(user_2)
  	self.friendships.create(friend: user_2)
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:friend)
  end
end
