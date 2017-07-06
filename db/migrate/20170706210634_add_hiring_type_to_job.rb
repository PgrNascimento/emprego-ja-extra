class AddHiringTypeToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :hiring_type, :string
  end
end
