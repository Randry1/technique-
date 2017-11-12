class AddTypeToMechanisms < ActiveRecord::Migration[5.0]
  def change
    add_column :mechanisms, :type, :string
  end
end
