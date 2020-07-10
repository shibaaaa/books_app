# frozen_string_literal: true

class AddProfilesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :postal, :integer
    add_column :users, :address, :string
    add_column :users, :introduction, :text
  end
end
