class CreateDirections < ActiveRecord::Migration[5.2]
  def change
    create_table :directions do |t|
      t.column :type, :string
      t.column :sequence_no, :integer
      t.column :instruction, :integer
      t.column :direction, :integer
      t.column :distance, :integer
      t.timestamps
    end
  end
end
