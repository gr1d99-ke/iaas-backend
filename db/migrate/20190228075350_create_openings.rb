class CreateOpenings < ActiveRecord::Migration[5.2]
  def change
    create_table :openings do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :company
      t.string :location
      t.string :description
      t.text :qualifications

      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
