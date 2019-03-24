class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.string :topic
      t.text :quick_description
      t.text :detailed_description
      t.text :sources

      t.timestamps
    end
  end
end
