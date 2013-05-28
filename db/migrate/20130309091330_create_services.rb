class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :name
      t.string :description1
      t.string :description2
      t.decimal :price
      t.integer :category

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
