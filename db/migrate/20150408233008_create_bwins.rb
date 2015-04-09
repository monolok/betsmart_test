class CreateBwins < ActiveRecord::Migration
  def change
    create_table :bwins do |t|
      t.string :home_team
      t.string :away_team
      t.timestamps null: false
    end
  end
end
