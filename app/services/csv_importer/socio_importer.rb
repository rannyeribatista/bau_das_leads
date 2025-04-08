# app/services/csv_importer/socio_importer.rb
require 'csv'

module CsvImporter
  class SocioImporter
    def self.import(file_path)
      puts "Iniciando importação de Sócios..."
      ActiveRecord::Base.transaction do
        data = File.read(file_path, mode: "rb")
                 .encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        CSV.parse(data, col_sep: ';', headers: false) do |row|
          # If you later decide to calculate faixa_etaria from a "DATA NASCIMENTO" field,
          # adjust the following accordingly.
          socio_attrs = {
            cnpj_basico:         row[0].to_s.strip,
            identificador_socio: row[1].to_i,
            nome_socio:          row[2].to_s.strip,
            cpf_cnpj:            mascarar_cpf(row[3].to_s.strip),
            qualificacao_socio:  row[4].to_s.strip,
            data_entrada:        (Date.parse(row[5]) rescue nil),
            pais:                row[6].to_s.strip,
            faixa_etaria:        0
          }
          Socio.find_or_create_by!(cnpj_basico: socio_attrs[:cnpj_basico], nome_socio: socio_attrs[:nome_socio]) do |socio|
            socio.assign_attributes(socio_attrs)
            puts "Socio criado ou atualizado: #{socio_attrs[:nome_socio]}"
          end
        rescue StandardError => e
          puts "Erro ao processar linha #{row.inspect}: #{e.message}"
          raise ActiveRecord::Rollback
        end
      end
      puts "Importação de Sócios finalizada."
    end

    def self.mascarar_cpf(cpf)
      return cpf unless cpf.length == 11
      "***#{cpf[3,6]}**"
    end
  end
end