class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :prefs

  has_many :authentications, :dependent => :destroy
  has_many :entries #, :dependent => :destroy
  has_many :recent_activities, :as => :actor, :class_name => "TimelineEvent", :order => "timeline_events.created_at DESC"
  has_many :user_items
  has_many :items, :through => :user_items, :uniq => true

  # user preferences
  serialize :prefs, UserPreference
  def prefs; read_attribute(:prefs) || UserPreference.new end
  def prefs=(hash); write_attribute :prefs, UserPreference.new(hash) end


  make_voter
  acts_as_followable

  include Gravtastic
  gravtastic :default => "wavatar"

  def to_s; name || email end
  
  def photo(type=:thumb)
    gravatar_url(:size => 40)
  end
  
  def has_this?(item); self.items.find_by_key(item.key) end

  # def confirmation_required?; false end

  # for omniauth authentication

  def apply_omniauth(omniauth, confirmation)
    # self.email = omniauth['user_info']['email'] if email.blank?
    apply_trusted_services(omniauth, confirmation) if self.new_record?
  end

  # Create a new user
  def apply_trusted_services(omniauth, confirmation)  
    # Merge user_info && extra.user_info
    user_info = omniauth['user_info']
    if omniauth['extra'] && omniauth['extra']['user_hash']
      user_info.merge!(omniauth['extra']['user_hash'])
    end  
    # try name or nickname
    if self.name.blank?
      self.name   = user_info['name']   unless user_info['name'].blank?
      self.name ||= user_info['nickname'] unless user_info['nickname'].blank?
      self.name ||= (user_info['first_name']+" "+user_info['last_name']) unless \
        user_info['first_name'].blank? || user_info['last_name'].blank?
    end   
    if self.email.blank?
      # self.email = user_info['email'] || "#{omniauth['provider']}+#{user_info['id']}@jigso.com" # just fake email
    end  
    # Set a random password for omniauthenticated users
    # self.password, self.password_confirmation = Devise.friendly_token[0,16]
    if (confirmation) 
      self.confirmed_at, self.confirmation_sent_at = Time.now  
    end 
  end
  
  
  # # ===================================== #
  # # ===================================== #
  # # ========  OVERWRITE METHODS  ======== #
  # # ===================================== #
  # # ===================================== #
  # def update_with_password(params={})
  #   current_password = params.delete(:current_password)
  #   check_password = true
  #   if params[:password].blank?
  #     params.delete(:password)
  #     if params[:password_confirmation].blank?
  #       params.delete(:password_confirmation)
  #       check_password = false
  #     end 
  #   end
  #   result = if valid_password?(current_password) || !check_password
  #     update_attributes(params)
  #   else
  #     self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
  #     self.attributes = params
  #     false
  #   end
  #   clean_up_passwords
  #   result
  # end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  up_votes               :integer         default(0), not null
#  down_votes             :integer         default(0), not null
#

