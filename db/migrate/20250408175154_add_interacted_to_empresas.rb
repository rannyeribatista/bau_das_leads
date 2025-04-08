class AddInteractedToEmpresas < ActiveRecord::Migration[8.0]
  def change
    add_column :empresas, :interacted, :boolean, default: false
  end
end
