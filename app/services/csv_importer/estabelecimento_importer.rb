# app/services/csv_importer/estabelecimento_importer.rb
require 'csv'

module CsvImporter
  class EstabelecimentoImporter
    def self.import(file_path)
      puts "Iniciando importação de Estabelecimentos..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          estabelecimento_attrs = {
            cnpj_basico:             row[0].to_s.strip,
            cnpj_ordem:              row[1].to_s.strip,
            cnpj_dv:                 row[2].to_s.strip,
            identificador:           row[3].to_i,
            nome_fantasia:           row[4].to_s.strip,
            situacao_cadastral:      row[5].to_s.strip,
            data_situacao:           (Date.parse(row[6]) rescue nil),
            motivo_situacao:         row[7].to_s.strip,
            nome_cidade_exterior:    row[8].to_s.strip,
            pais:                    row[9].to_s.strip,
            data_inicio_atividade:   (Date.parse(row[10]) rescue nil),
            cnae_fiscal_principal:    row[11].to_s.strip,
            cnae_fiscal_secundaria:   row[12].to_s.strip,
            tipo_logradouro:         row[13].to_s.strip,
            logradouro:              row[14].to_s.strip,
            numero:                  row[15].to_s.strip,
            complemento:             row[16].to_s.strip,
            bairro:                  row[17].to_s.strip,
            cep:                     row[18].to_s.strip,
            uf:                      row[19].to_s.strip,
            municipio:               row[20].to_s.strip
          }
          Estabelecimento.find_or_create_by!(cnpj_basico: estabelecimento_attrs[:cnpj_basico], cnpj_ordem: estabelecimento_attrs[:cnpj_ordem]) do |est|
            est.assign_attributes(estabelecimento_attrs)
            puts "Importando Estabelecimento: #{estabelecimento_attrs[:nome_fantasia]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Estabelecimentos finalizada."
    end
  end
end