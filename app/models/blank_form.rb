class BlankForm < ApplicationRecord
  belongs_to :department

  validates :eng_name, :hindi_name, :section, :section_hindi,  presence: true 
end
