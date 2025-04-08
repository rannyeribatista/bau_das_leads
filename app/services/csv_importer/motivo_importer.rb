# app/services/csv_importer/motivo_importer.rb
require 'csv'

module CsvImporter
  class MotivoImporter
    def self.import(file_path)
      puts "Iniciando importação de Motivos..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          puts "Processando linha #{row.inspect}"
          motivo_attrs = {
            codigo: row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Motivo.find_or_create_by!(codigo: motivo_attrs[:codigo]) do |motivo|
            motivo.assign_attributes(motivo_attrs)
            puts "Motivo criado ou atualizado: #{motivo_attrs[:codigo]} - #{motivo_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Motivos finalizada."
    end
  end
end