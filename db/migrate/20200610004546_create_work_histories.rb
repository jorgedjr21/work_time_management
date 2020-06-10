class CreateWorkHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :work_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :work_history_type, index: true
      t.datetime :instant

      t.timestamps
    end
  end
end
