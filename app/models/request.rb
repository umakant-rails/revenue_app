class Request < ApplicationRecord
  
  has_many :participants
  has_many :khasras
  belongs_to :village
  belongs_to :user
  has_one :payment_transaction, as: :transactionable

  paginates_per 10

  validates :applicant, :relation, :gaurdian, :address, :request_type, :year,  presence: true 

  # accepts_nested_attributes_for :khasras, allow_destroy: true
  OP_TYPES = ["नामांतरण", "बटवारा", "फौती"]
  RELATIONS = ['पुत्र','पुत्री', 'पत्नी']
  UNITS = ['व.फु.', 'व.मी.', 'हे.']
  TEMPLATES = [['प्रारूप-35', 'pdf-paragraph-35'], ['प्रारूप-40', 'pdf-paragraph-40'], ['प्रारूप-45', 'pdf-paragraph-45']]
  FAUTI_ORDER_PRAROOP = [["आदेश प्रारूप-1", "p1"], ["आदेश प्रारूप-2", "p2"], ["आदेश प्रारूप-3", "p3"]]
  NAMANTARAN_ORDER_PRAROOP = [["आदेश प्रारूप-1", "p1"], ["आदेश प्रारूप-2", "p2"]]
  SANJARA_PRAROOP = [["संजरा प्रारूप-1", "p1"], ["संजरा प्रारूप-2", "p2"]]

  def buyer_name
    return self.applicant + " " + self.relation + " " + self.gaurdian
  end

end
