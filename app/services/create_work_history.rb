# frozen_string_literal: true

class CreateWorkHistory

  def initialize(work_history_params)
    @work_history = WorkHistory.new(work_history_params)
  end

  def self.call(form_params, user_id)
    form_params.merge!({ user_id: user_id })
    new(form_params).execute
  end

  def execute
    return OpenStruct.new(success?: false, work_history: @work_history) unless @work_history.save

    OpenStruct.new(success?: true, work_history: @work_history)
  end
end