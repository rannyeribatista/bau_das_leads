# app/services/csv_importer/municipio_importer.rb
require 'csv'

module CsvImporter
  class MunicipioImporter
    def self.import(file_path)
      puts "Iniciando importação de Municípios..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          puts "Processando linha #{row.inspect}"
          municipio_attrs = {
            codigo: row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Municipio.find_or_create_by!(codigo: municipio_attrs[:codigo]) do |municipio|
            municipio.assign_attributes(municipio_attrs)
            puts "Município criado ou atualizado: #{municipio_attrs[:codigo]} - #{municipio_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Municípios finalizada."
    end
  end
end