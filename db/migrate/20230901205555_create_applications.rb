class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
