class WorkHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @work_histories = WorkHistory.by_user(current_user.id)
    @work_histories = @work_histories.from_today if params[:today].present?
  end
  
  def new
    @work_history = WorkHistory.new
  end
  
  def create
    create_result = CreateWorkHistory.call(work_history_params, current_user.id)
    if create_result.success?
      redirect_to root_path, flash: { notice: t('activerecord.success.models.work_history.create') }
    else
      @work_history = create_result.work_history
      render :new
    end
  end

  private

  def work_history_params 
    params.require(:work_history).permit(:instant_date, :instant_time, :work_history_type)
  end

end 