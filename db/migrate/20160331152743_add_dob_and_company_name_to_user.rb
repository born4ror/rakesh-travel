class AddDobAndCompanyNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :company_name, :string
    add_column :users, :avatar, :string
    add_column :users, :name, :string
  end
end
