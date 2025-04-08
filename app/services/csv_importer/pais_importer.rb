# app/services/csv_importer/pais_importer.rb
require 'csv'

module CsvImporter
  class PaisImporter
    def self.import(file_path)
      puts "Iniciando importação de Países..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          pais_attrs = {
            codigo: row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Pais.find_or_create_by!(codigo: pais_attrs[:codigo]) do |pais|
            pais.assign_attributes(pais_attrs)
            puts "País criado ou atualizado: #{pais_attrs[:codigo]} - #{pais_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Países finalizada."
    end
  end
end