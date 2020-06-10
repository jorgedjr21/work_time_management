class WorkHistoryReports
  def self.total_work_histories_by_user(user_id)
    WorkHistory.where(user_id: user_id).count
  end

  def self.total_work_histories_today_by_user(user_id)
    WorkHistory.from_today.where(user_id: user_id).count
  end
end