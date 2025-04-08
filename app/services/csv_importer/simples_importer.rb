# app/services/csv_importer/simples_importer.rb
require 'csv'

module CsvImporter
  class SimplesImporter
    def self.import(file_path)
      puts "Iniciando importação de Simples..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          simples_attrs = {
            cnpj_basico:            row[0].to_s.strip,
            opcao_pelo_simples:     row[1].to_s.strip,
            data_opcao_simples:     (Date.parse(row[2]) rescue nil),
            data_exclusao_simples:  (Date.parse(row[3]) rescue nil),
            opcao_pelo_mei:         row[4].to_s.strip,
            data_opcao_mei:         (Date.parse(row[5]) rescue nil),
            data_exclusao_mei:      (Date.parse(row[6]) rescue nil)
          }
          Simples.find_or_create_by!(cnpj_basico: simples_attrs[:cnpj_basico]) do |simples|
            simples.assign_attributes(simples_attrs)
            puts "Simples criado ou atualizado: #{simples_attrs[:cnpj_basico]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Simples finalizada."
    end
  end
end