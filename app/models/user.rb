class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  #has_many :articles, :dependent => :destroy

  attr_accessor :login
  has_many :comments, :dependent => :destroy
  #field :email,              :type => String, :default => ""
  #field :encrypted_password, :type => String, :default => ""
  #has_and_belongs_to_many :article

  #validates :email, :fullname, :contactNumber, :username, :userRole, presence: true
  #validates_uniqueness_of :email, :contactNumber
  #validates_length_of :contactNumber, minimum: 10, maximum: 12
 
 # attr_accessible :email, :password, :password_confirmation, :fullname

  #field :reset_password_token,   type: String
  #field :reset_password_sent_at, type: Time

  #field :remember_created_at, type: Time

  ## Trackable
  #field :sign_in_count,      type: Integer, default: 0
  #field :current_sign_in_at, type: Time
  #field :last_sign_in_at,    type: Time
  #field :current_sign_in_ip, type: String
  #field :last_sign_in_ip,    type: String


  def set_default_role
    self.role ||= :user
  end
end
