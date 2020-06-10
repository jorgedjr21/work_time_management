class WorkHistory < ApplicationRecord
  belongs_to :user

  enum work_history_type: { entrance: 0, out_for_lunch: 1, lunch_arrival: 2, end_day: 3 }
end
