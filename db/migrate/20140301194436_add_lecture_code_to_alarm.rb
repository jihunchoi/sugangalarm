class AddLectureCodeToAlarm < ActiveRecord::Migration
  def change
    add_column :alarms, :lecture_code, :string
  end
end
