# app/services/airtable_exporter.rb
class AirtableExporter
  def self.export_lead(empresa)
    # TODO: Add fields here once all ready
    # Prepare a hash to map your empresa fields to Airtable fields:
    airtable_attributes = {
      "CNPJ"         => empresa.cnpj_basico,
      "Razao Social" => empresa.razao_social,
      "Natureza"     => empresa.natureza_juridica,
      # ... add additional fields as needed
    }

    # Create a record on Airtable.
    record = AirtableLead.create(airtable_attributes)

    if record.present?
      # Mark the empresa record as interacted to avoid duplicate exports.
      empresa.update(interacted: true)
      return true
    else
      return false
    end
  rescue => e
    Rails.logger.error "Error exporting empresa #{empresa.id} to Airtable: #{e.message}"
    return false
  end
end