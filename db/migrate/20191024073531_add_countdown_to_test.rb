class AddCountdownToTest < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :countdown, :integer
  end
end
