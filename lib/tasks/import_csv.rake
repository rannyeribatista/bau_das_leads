# lib/tasks/import_csv.rake
namespace :import do
  desc "Importa dados do CSV de Empresas"
  task empresas: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'empresas.csv')
    CsvImporter::EmpresaImporter.import(file_path)
  end

  desc "Importa dados do CSV de Estabelecimentos"
  task estabelecimentos: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'estabelecimentos.csv')
    CsvImporter::EstabelecimentoImporter.import(file_path)
  end

  desc "Importa dados do CSV de Sócios"
  task socios: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'socios.csv')
    CsvImporter::SocioImporter.import(file_path)
  end

  desc "Importa dados do CSV de Simples"
  task simples: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'simples.csv')
    CsvImporter::SimplesImporter.import(file_path)
  end

  # Domain tables
  desc "Importa dados do CSV de CNAEs"
  task cnaes: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'cnaes.csv')
    CsvImporter::CnaeImporter.import(file_path)
  end

  desc "Importa dados do CSV de Motivos"
  task motivos: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'motivos.csv')
    CsvImporter::MotivoImporter.import(file_path)
  end

  desc "Importa dados do CSV de Municípios"
  task municipios: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'municipios.csv')
    CsvImporter::MunicipioImporter.import(file_path)
  end

  desc "Importa dados do CSV de Naturezas"
  task naturezas: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'naturezas.csv')
    CsvImporter::NaturezaImporter.import(file_path)
  end

  desc "Importa dados do CSV de Países"
  task paises: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'paises.csv')
    CsvImporter::PaisImporter.import(file_path)
  end

  desc "Importa dados do CSV de Qualificações"
  task qualificacoes: :environment do
    file_path = Rails.root.join('lib', 'import_files', 'qualificacoes.csv')
    CsvImporter::QualificacaoImporter.import(file_path)
  end

  # You can combine tasks for domains
  desc "Importa todos os CSVs de domínios"
  task dominios: :environment do
    Rake::Task["import:cnaes"].invoke
    Rake::Task["import:motivos"].invoke
    Rake::Task["import:municipios"].invoke
    Rake::Task["import:naturezas"].invoke
    Rake::Task["import:paises"].invoke
    Rake::Task["import:qualificacoes"].invoke
  end

  # A single task to import all CSVs
  desc "Importa todos os CSVs (Domínios, Empresas, Estabelecimentos, Sócios e Simples)"
  task all: :environment do
    Rake::Task["import:dominios"].invoke
    Rake::Task["import:empresas"].invoke
    Rake::Task["import:estabelecimentos"].invoke
    Rake::Task["import:socios"].invoke
    Rake::Task["import:simples"].invoke
  end
end