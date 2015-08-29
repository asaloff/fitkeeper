class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :weight, :time
      t.string :time_type
      t.integer :sets, :reps
      t.timestamps
    end
  end
end
