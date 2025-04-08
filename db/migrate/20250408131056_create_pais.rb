class CreatePais < ActiveRecord::Migration[8.0]
  def change
    create_table :pais do |t|
      t.string :codigo
      t.string :descricao

      t.timestamps
    end
  end
end
