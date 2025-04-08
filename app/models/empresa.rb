class Empresa < ApplicationRecord
  has_many :estabelecimentos, primary_key: 'cnpj_basico', foreign_key: 'cnpj_basico'
  has_many :socios, primary_key: 'cnpj_basico', foreign_key: 'cnpj_basico'

  scope :not_interacted, -> { where(interacted: [false, nil]) }
  
  validates :cnpj_basico, presence: true, uniqueness: { allow_blank: true }
end
