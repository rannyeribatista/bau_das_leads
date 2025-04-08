# app/services/csv_importer/empresa_importer.rb
require 'csv'

module CsvImporter
  class EmpresaImporter
    def self.import(file_path)
      puts "Iniciando importação de Empresas..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          empresa_attrs = {
            cnpj_basico:             row[0].to_s.strip,
            razao_social:            row[1].to_s.strip,
            natureza_juridica:       row[2].to_s.strip,
            qualificacao_responsavel: row[3].to_s.strip,
            capital_social:          row[4].to_d,
            porte:                   row[5].to_s.strip,
            ente_federativo:         row[6].to_s.strip
          }
          Empresa.find_or_create_by!(cnpj_basico: empresa_attrs[:cnpj_basico]) do |empresa|
            empresa.assign_attributes(empresa_attrs)
            puts "Importando Empresa: #{empresa_attrs[:razao_social]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Empresas finalizada."
    end
  end
end