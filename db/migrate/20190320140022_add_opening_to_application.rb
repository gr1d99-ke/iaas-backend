class AddOpeningToApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :opening, foreign_key: true
  end
end
