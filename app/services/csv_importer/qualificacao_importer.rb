# app/services/csv_importer/qualificacao_importer.rb
require 'csv'

module CsvImporter
  class QualificacaoImporter
    def self.import(file_path)
      puts "Iniciando importação de Qualificações..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          qualificacao_attrs = {
            codigo: row[0].to_s.strip,
            descricao: row[1].to_s.strip
          }
          Qualificacao.find_or_create_by!(codigo: qualificacao_attrs[:codigo]) do |qualificacao|
            qualificacao.assign_attributes(qualificacao_attrs)
            puts "Qualificação criada ou atualizada: #{qualificacao_attrs[:codigo]} - #{qualificacao_attrs[:descricao]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Qualificações finalizada."
    end
  end
end