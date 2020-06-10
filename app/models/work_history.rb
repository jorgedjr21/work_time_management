class WorkHistory < ApplicationRecord
  attr_accessor :instant_date, :instant_time
  
  belongs_to :user
  enum work_history_type: { entrance: 0, out_for_lunch: 1, lunch_arrival: 2, end_day: 3 }
  
  before_save :set_instant
  validates :work_history_type, presence: true, inclusion: { in: WorkHistory.work_history_types.keys }
  validates :instant_date, presence: true, allow_blank: false
  validates :instant_time, presence: true, allow_blank: false

  private

  def set_instant
    errors.add(:instant_date, 'blank') if instant_date.blank?
    errors.add(:instant_time, 'blank') if instant_time.blank?

    self.instant = Time.zone.parse("#{instant_date} #{instant_time}") if valid?
  end
end
