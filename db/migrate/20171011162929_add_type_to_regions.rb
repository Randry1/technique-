class AddTypeToRegions < ActiveRecord::Migration[5.0]
  def change
    add_column :regions, :type, :string
  end
end
