class Participant < ApplicationRecord

  has_many :children, class_name: :Participant, foreign_key: :parent_id
  has_many :varsan, class_name: :Participant, foreign_key: :parent_id
  belongs_to :parent, class_name: :Participant, foreign_key: :parent_id, optional: true
  belongs_to :request
  
  scope :fout_person, ->() { where('parent_id is null') }
  scope :fout_varsan, ->() { where('karanda_aam_faut=? and parent_id is not null', true) }
  scope :fout_participants, ->() { where('karanda_aam_faut=?', true) }
  scope :son, ->() { where("relation_to_deceased='पुत्र'")}
  scope :daughter, ->() { where("relation_to_deceased='पुत्री'")}
  scope :wife_husband, ->() { where("relation_to_deceased='पत्नी' or relation_to_deceased='पति'")}
  scope :varsan, ->() { where("parent_id is not null")}

  validates :name, :relation, :gaurdian,  presence: true 

  CLASSIFICATIONS = ['पुत्र','पुत्री', 'पत्नी', 'पति', 'अन्य']
end
