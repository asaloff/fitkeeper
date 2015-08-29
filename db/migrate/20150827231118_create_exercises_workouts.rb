class CreateExercisesWorkouts < ActiveRecord::Migration
  def change
    create_table :exercises_workouts do |t|
      t.integer :workout_id, :exercise_id
      t.timestamps
    end
  end
end
