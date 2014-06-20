class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
