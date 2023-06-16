class Participant < ApplicationRecord

  has_many :children, class_name: :Participant, foreign_key: :parent_id
  has_many :varsan, class_name: :Participant, foreign_key: :parent_id
  belongs_to :parent, class_name: :Participant, foreign_key: :parent_id, optional: true
  belongs_to :request
  belongs_to :participant_type
  
  scope :applicant, -> () { find_by_is_applicant(true)}
  scope :buyers, -> () { where("participant_type_id = 1")}
  scope :sellers, -> () { where("participant_type_id = 2")}

  scope :land_owner, -> () { where("participant_type_id in (?)", [6,7]) }
  scope :hissedar, -> (){ where("participant_type_id in (?)", [7,8]) }

  scope :fout_person, ->() { where('parent_id is null and death_date is not null') }
  scope :fout_varsan, ->() { where('is_dead=? and parent_id is not null', true) }
  scope :fout_participants, ->() { where('is_dead=?', true) }
  scope :son, ->() { where("relation_to_deceased='पुत्र'")}
  scope :daughter, ->() { where("relation_to_deceased='पुत्री'")}
  scope :wife_husband, ->() { where("relation_to_deceased='पत्नी' or relation_to_deceased='पति'")}
  scope :varsan, ->() { where("parent_id is not null")}

  validates :name, :relation, :gaurdian, :address,  presence: true 

  RELATIONS = ['पुत्र','पुत्री', 'पत्नी']
  RELATIONS_TO_DECEASED = ['पुत्र','पुत्री', 'पत्नी', 'पति', 'अन्य']
  SWAMITVA_STATUS=[["पूर्ण भूमि स्वामी", false], ["सह-खातेदार", true]]
  BOOLEAN_STATUS =[["नहीं ", false], ["हाँ", true]]

end
