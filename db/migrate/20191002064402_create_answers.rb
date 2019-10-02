class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :correct, default: false
      t.integer :question_id

      t.timestamps
    end
  end
end
