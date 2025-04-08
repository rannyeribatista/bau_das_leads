# Baú das Leads

Baú das Leads is a Ruby on Rails application designed to import and manage the Brazilian CNPJ dataset from CSV files. The application builds a relational database from various CSVs covering companies, establishments, partners, and more. It provides a clean, responsive interface (using Tailwind CSS) for filtering and viewing leads, with built-in Airtable export functionality that marks leads as "interacted" to avoid duplicate exports.

## Features

- **CSV Import:**  
  Import CSV files without headers, using fixed column positions based on the official layout.
  - Domain data: CNAEs, Motivos, Municípios, Naturezas, Países, and Qualificações.
  - Main data: Empresas, Estabelecimentos, Sócios, and Simples.

- **Robust Import Processing:**  
  Handles encoding issues by forcing UTF-8 conversion to avoid malformed byte sequences.
  
- **Responsive User Interface:**  
  Built with Tailwind CSS to deliver a clean, mobile-friendly experience.
  - Filter companies by CNPJ, CNAE, and contact availability.
  - Visual indicators for leads already "interacted".
  - Pagination powered by Pagy.

- **Airtable Integration:**  
  Export leads to an Airtable base. Each exported lead is marked as "interacted" to ensure it isn’t sent twice.
  
- **Extensible and Modular:**  
  Designed for easy customization. Future enhancements (like ChatGPT integration) can be implemented using the service object pattern.

## Tech Stack

- **Ruby on Rails 8**
- **PostgreSQL** (or your preferred database)
- **Tailwind CSS**
- **Pagy** for pagination
- **Airrecord** for Airtable integration

## Getting Started

### Prerequisites

- Ruby (3.2.2 recommended)
- Rails 8.x
- PostgreSQL
- Git
- [Bundler](https://bundler.io/)

### Setup

1. **Clone the Repository:**

   ```bash
   git clone git@github.com:YOUR_USERNAME/bau_das_leads.git
   cd bau_das_leads
   ```

2. **Install Dependencies:**

   ```bash
    bundle install
    ```

3. **Configure Environment Variables:**

   Create a .env file or configure your Rails credentials with the following variables:

   ```bash
    AIRTABLE_API_KEY=your_airtable_api_key
    AIRTABLE_BASE_ID=your_airtable_base_id
    AIRTABLE_TABLE_NAME=Leads    # Adjust to match your Airtable table name
    OPENAI_API_KEY=your_openai_api_key  # (Optional, for future ChatGPT integration)
    ```

4. **Setup Database:**

   ```bash
    rails db:create
    rails db:migrate
    ```

5. **Install Tailwind CSS:**

   If not already installed:

   ```bash
    rails tailwindcss:install
    ```

### Importing Data

Place your CSV files (without headers) into the lib/import_files directory. The expected file names are:

- cnaes.csv
- motivos.csv
- municipios.csv
- naturezas.csv
- paises.csv
- qualificacoes.csv
- empresas.csv
- estabelecimentos.csv
- socios.csv
- simples.csv

### Recommended Import Order

Ensure that domain data is imported before main data:

#### Domain Tables:

- bundle exec rake import:cnaes
- bundle exec rake import:motivos
- bundle exec rake import:municipios
- bundle exec rake import:naturezas
- bundle exec rake import:paises
- bundle exec rake import:qualificacoes

Or run all domain imports at once:

- bundle exec rake import:dominios

#### Main Data Tables:

- bundle exec rake import:empresas
- bundle exec rake import:estabelecimentos
- bundle exec rake import:socios
- bundle exec rake import:simples

#### Import Everything:

- bundle exec rake import:all

### Running the Server

Start the Rails server:

```bash
bundle exec rails s
```

Then visit http://localhost:3000 to view the responsive leads interface, apply filters, and perform Airtable exports.

## Airtable Integration

The application uses the airrecord gem to create and update records on Airtable. Exporting a lead sends selected company information (along with a personalized email field, if enabled) to Airtable, then marks the lead as "interacted" in the local database.

## License

MIT

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Acknowledgements

- Ruby on Rails
- Tailwind CSS
- Pagy
- Airrecord