class CreateInstructorApplications < ActiveRecord::Migration
  def self.up
    create_table :instructor_applications do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :instructor_applications
  end
end
