class CreateEmpresas < ActiveRecord::Migration[8.0]
  def change
    create_table :empresas do |t|
      t.string :cnpj_basico
      t.string :razao_social
      t.string :natureza_juridica
      t.string :qualificacao_responsavel
      t.decimal :capital_social
      t.string :porte
      t.string :ente_federativo

      t.timestamps
    end
  end
end
