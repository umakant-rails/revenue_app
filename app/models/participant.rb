class Participant < ApplicationRecord

  has_many :children, class_name: :Participant, foreign_key: :parent_id
  has_many :varsan, class_name: :Participant, foreign_key: :parent_id
  belongs_to :parent, class_name: :Participant, foreign_key: :parent_id, optional: true
  belongs_to :request
  belongs_to :participant_type
  
  scope :applicants, -> () { where("participant_type_id = 1")}
  
  scope :fout_person, ->() { where('parent_id is null') }
  scope :fout_varsan, ->() { where('karanda_aam_faut=? and parent_id is not null', true) }
  scope :fout_participants, ->() { where('is_dead=?', true) }
  scope :son, ->() { where("relation_to_deceased='पुत्र'")}
  scope :daughter, ->() { where("relation_to_deceased='पुत्री'")}
  scope :wife_husband, ->() { where("relation_to_deceased='पत्नी' or relation_to_deceased='पति'")}
  scope :varsan, ->() { where("parent_id is not null")}

  validates :name, :relation, :gaurdian,  presence: true 

  RELATIONS = ['पुत्र','पुत्री', 'पत्नी']
  RELATIONS_TO_DECEASED = ['पुत्र','पुत्री', 'पत्नी', 'पति', 'अन्य']
  PARTICIPANT_TYPES = ["आवेदक", "अनावेदक", "करंदा-आम", "वारसान", "फौत व्यक्ति"]
  SWAMITVA_STATUS=[["पूर्ण भूमि स्वामी", false], ["सह-खातेदार", true]]
  SOLD_SHARE_STATUS=[["नहीं ", false], ["हाँ", true]]

end
