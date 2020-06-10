module WorkHistoriesHelper
  def work_history_table_header(work_history = nil)
    return [] if work_history.blank?

    work_history.attributes.keys.reject  { |k| %w[id created_at updated_at user_id].include?(k) }
  end
end