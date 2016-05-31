class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :avatar
      t.date :submission_date
      t.text :description
      t.integer :user_id
      t.string :name_color
      t.string :name_font_size
      t.string :date_color
      t.string :date_font_size
      t.string :description_color
      t.string :description_text_color

      t.timestamps null: false
    end
  end
end
