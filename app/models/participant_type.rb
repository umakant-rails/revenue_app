class ParticipantType < ApplicationRecord
  has_many :participants

  scope :pa, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }

  def self.get_participants(request)
    if request.request_type.name == "नामांतरण"
      self.where("name in (?)", ["आवेदक", "अनावेदक", "करांदा-आम"])
    elsif request.request_type.name == "नामांतरण"
      self.where("name in (?)", ["आवेदक", "फौत व्यक्ति", "वारसान"])
    elsif request.request_type.name == "फौती"
      self.where("name in (?)", ["आवेदक", "मूल भू स्वामी", "नए हिस्सेदार"])
    end
  end

end
