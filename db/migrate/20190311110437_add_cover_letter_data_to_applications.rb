class AddCoverLetterDataToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :cover_letter_data, :text
  end
end
