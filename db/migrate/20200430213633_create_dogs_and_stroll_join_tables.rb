class CreateDogsAndStrollJoinTables < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs_and_stroll_join_tables do |t|

      t.timestamps
    end
  end
end
