class HomeController < ApplicationController
  def index
    if user_signed_in? 
      @work_history_reports = {
        total: WorkHistoryReports.total_work_histories_by_user(current_user.id),
        today: WorkHistoryReports.total_work_histories_today_by_user(current_user.id),
      }
    end
  end
end 