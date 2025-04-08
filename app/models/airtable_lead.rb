# app/models/airtable_lead.rb
class AirtableLead < Airrecord::Table
  self.base_key = ENV["AIRTABLE_BASE_ID"]
  self.table_name = ENV["AIRTABLE_TABLE_NAME"]
end