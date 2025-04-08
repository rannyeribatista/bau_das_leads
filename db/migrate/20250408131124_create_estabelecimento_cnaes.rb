class CreateEstabelecimentoCnaes < ActiveRecord::Migration[8.0]
  def change
    create_table :estabelecimento_cnaes do |t|
      t.references :estabelecimento, null: false, foreign_key: true
      t.references :cnae, null: false, foreign_key: true

      t.timestamps
    end
  end
end
