# app/services/csv_importer/natureza_importer.rb
require 'csv'

module CsvImporter
  class NaturezaImporter
    def self.import(file_path)
      puts "Iniciando importação de Naturezas..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          natureza_attrs = {
            codigo: row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Natureza.find_or_create_by!(codigo: natureza_attrs[:codigo]) do |natureza|
            natureza.assign_attributes(natureza_attrs)
            puts "Natureza criada ou atualizada: #{natureza_attrs[:codigo]} - #{natureza_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Naturezas finalizada."
    end
  end
end