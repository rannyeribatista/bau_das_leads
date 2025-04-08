# app/controllers/empresas_controller.rb
class EmpresasController < ApplicationController
  include Pagy::Backend

  def index
    companies = Empresa.all

    # Filter by CNPJ (partial match)
    companies = companies.where("cnpj_basico LIKE ?", "%#{params[:cnpj]}%") if params[:cnpj].present?

    # Filter by CNAE (using join with estabelecimentos)
    if params[:cnae].present?
      companies = companies.joins(:estabelecimentos)
                           .where("estabelecimentos.cnae_fiscal_principal = ?", params[:cnae])
    end

    # Filter leads that have some contact information (example using telefone1 or correio_eletronico)
    if params[:has_contact].present? && params[:has_contact] == "1"
      companies = companies.joins(:estabelecimentos)
                           .where(" (estabelecimentos.telefone1 IS NOT NULL AND estabelecimentos.telefone1 <> '') OR (estabelecimentos.correio_eletronico IS NOT NULL AND estabelecimentos.correio_eletronico <> '')")
    end

    # Filter out leads that have already been interacted with if the user checked the filter option.
    if params[:exclude_interacted].present? && params[:exclude_interacted] == "1"
      companies = companies.where(interacted: [false, nil])
    end

    companies = companies.distinct

    @pagy, @empresas = pagy(companies, items: 100)
  end
  
  def export
    empresa = Empresa.find(params[:id])
    if AirtableExporter.export_lead(empresa)
      flash[:notice] = "Lead exported successfully and marked as interacted."
    else
      flash[:alert] = "There was an error exporting the lead."
    end
    redirect_to empresas_path
  end
end