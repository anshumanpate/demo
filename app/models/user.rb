class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def admin?
          self.admin
        end

       
  def connections
    Connection.where('requester_id = ? OR requestee_id = ?', id, id)
  end
 has_many :sent_requests, class_name: 'Connection', foreign_key: 'requester_id'
 has_many :received_requests, class_name: 'Connection', foreign_key: 'requestee_id'
end
