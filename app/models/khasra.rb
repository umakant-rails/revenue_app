class Khasra < ApplicationRecord
  belongs_to :request
  belongs_to :village

  validates :khasra, :rakba,  presence: true 

end
