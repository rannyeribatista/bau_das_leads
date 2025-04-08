class CreateNaturezas < ActiveRecord::Migration[8.0]
  def change
    create_table :naturezas do |t|
      t.string :codigo
      t.string :descricao

      t.timestamps
    end
  end
end
