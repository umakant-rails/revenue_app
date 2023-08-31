class BlankForm < ApplicationRecord
  belongs_to :department

  validates :eng_name, :hindi_name, :section_eng, :section_hindi,  presence: true 
end
