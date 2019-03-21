class AddResumeDataToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :resume_data, :text
  end
end
