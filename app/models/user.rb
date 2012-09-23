class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :account_hash
  has_and_belongs_to_many :roles
  has_many :sites
  # attr_accessible :title, :body
  def has_role?(role) 
  	self.roles.count(:conditions => ['name = ?', role]) > 0 
  end
end
