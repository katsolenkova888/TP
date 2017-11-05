class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
	t.text :text1

      t.timestamps
    end
  end
end
