# app/services/csv_importer/cnae_importer.rb
require 'csv'

module CsvImporter
  class CnaeImporter
    def self.import(file_path)
      puts "Iniciando importação de CNAEs..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          cnae_attrs = {
            codigo:    row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Cnae.find_or_create_by!(codigo: cnae_attrs[:codigo]) do |cnae|
            cnae.assign_attributes(cnae_attrs)
            puts "Importando CNAE: #{cnae_attrs[:codigo]} - #{cnae_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de CNAEs finalizada."
    end
  end
end