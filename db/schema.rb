# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_08_131124) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cnaes", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string "cnpj_basico"
    t.string "razao_social"
    t.string "natureza_juridica"
    t.string "qualificacao_responsavel"
    t.decimal "capital_social"
    t.string "porte"
    t.string "ente_federativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estabelecimento_cnaes", force: :cascade do |t|
    t.bigint "estabelecimento_id", null: false
    t.bigint "cnae_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnae_id"], name: "index_estabelecimento_cnaes_on_cnae_id"
    t.index ["estabelecimento_id"], name: "index_estabelecimento_cnaes_on_estabelecimento_id"
  end

  create_table "estabelecimentos", force: :cascade do |t|
    t.string "cnpj_basico"
    t.string "cnpj_ordem"
    t.string "cnpj_dv"
    t.integer "identificador"
    t.string "nome_fantasia"
    t.string "situacao_cadastral"
    t.date "data_situacao"
    t.string "motivo_situacao"
    t.string "tipo_logradouro"
    t.string "logradouro"
    t.string "numero"
    t.string "complemento"
    t.string "bairro"
    t.string "cep"
    t.string "uf"
    t.string "municipio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "motivos", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipios", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "naturezas", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pais", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qualificacaos", force: :cascade do |t|
    t.string "codigo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "simples", force: :cascade do |t|
    t.string "cnpj_basico"
    t.string "opcao_pelo_simples"
    t.date "data_opcao_simples"
    t.date "data_exclusao_simples"
    t.string "opcao_pelo_mei"
    t.date "data_opcao_mei"
    t.date "data_exclusao_mei"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socios", force: :cascade do |t|
    t.string "cnpj_basico"
    t.integer "identificador_socio"
    t.string "nome_socio"
    t.string "cpf_cnpj"
    t.string "qualificacao_socio"
    t.date "data_entrada"
    t.string "pais"
    t.integer "faixa_etaria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "estabelecimento_cnaes", "cnaes"
  add_foreign_key "estabelecimento_cnaes", "estabelecimentos"
end
