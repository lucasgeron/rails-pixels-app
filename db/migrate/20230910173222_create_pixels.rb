class CreatePixels < ActiveRecord::Migration[7.0]
  def change
    create_table :pixels do |t|
      t.string :color

      t.timestamps
    end
  end
end
