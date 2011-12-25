class AddLanguageToClients < ActiveRecord::Migration
  def change
    add_column :clients, :language, :string
    add_index  :clients, :language
  end
end
