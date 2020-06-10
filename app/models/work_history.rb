class WorkHistory < ApplicationRecord
  belongs_to :user
  enum work_history_type: { entrance: 0, out_for_lunch: 1, lunch_arrival: 2, end_day: 3 }
  
  validates :work_history_type, presence: true, inclusion: { in: WorkHistory.work_history_types.keys }
  validates :instant, presence: true, allow_blank: false
end
