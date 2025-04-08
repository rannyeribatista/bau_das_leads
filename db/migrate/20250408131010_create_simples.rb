class CreateSimples < ActiveRecord::Migration[8.0]
  def change
    create_table :simples do |t|
      t.string :cnpj_basico
      t.string :opcao_pelo_simples
      t.date :data_opcao_simples
      t.date :data_exclusao_simples
      t.string :opcao_pelo_mei
      t.date :data_opcao_mei
      t.date :data_exclusao_mei

      t.timestamps
    end
  end
end
