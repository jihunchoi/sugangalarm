class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.string :subject_code
      t.string :lecturer
      t.boolean :alarmed
      t.string :email

      t.timestamps
    end
  end
end
