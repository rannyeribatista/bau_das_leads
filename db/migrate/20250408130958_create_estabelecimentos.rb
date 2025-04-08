class CreateEstabelecimentos < ActiveRecord::Migration[8.0]
  def change
    create_table :estabelecimentos do |t|
      t.string :cnpj_basico
      t.string :cnpj_ordem
      t.string :cnpj_dv
      t.integer :identificador
      t.string :nome_fantasia
      t.string :situacao_cadastral
      t.date :data_situacao
      t.string :motivo_situacao
      t.string :tipo_logradouro
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :cep
      t.string :uf
      t.string :municipio

      t.timestamps
    end
  end
end
