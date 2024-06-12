class Connection < ApplicationRecord
    belongs_to :requester, class_name: 'User'
    belongs_to :requestee, class_name: 'User'

  STATUSES = %w[pending accepted cancelled blocked]

  validates :status, inclusion: { in: STATUSES }    
end
