class CreateSocios < ActiveRecord::Migration[8.0]
  def change
    create_table :socios do |t|
      t.string :cnpj_basico
      t.integer :identificador_socio
      t.string :nome_socio
      t.string :cpf_cnpj
      t.string :qualificacao_socio
      t.date :data_entrada
      t.string :pais
      t.integer :faixa_etaria

      t.timestamps
    end
  end
end
