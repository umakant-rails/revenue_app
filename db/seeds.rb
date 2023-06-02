# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "jack.jackjack25@gmail.com", username: "jack005", password: "12345678") if User.where(email: "jack.jackjack25@gmail.com").blank?

RequestType.create(name: "नामांतरण") if RequestType.where(name: "नामांतरण").blank?
RequestType.create(name: "बटवारा") if RequestType.where(name: "बटवारा").blank?
RequestType.create(name: "फौती") if RequestType.where(name: "फौती").blank?

# nama_req_type = RequestType.where(name: "नामांतरण").first rescue nil
# if nama_req_type.present?
#   nama_req_type.participant_types.create(name: "आवेदक") if nama_req_type.participant_types.where(name: "आवेदक").blank?
#   nama_req_type.participant_types.create(name: "अनावेदक") if nama_req_type.participant_types.where(name: "अनावेदक").blank?
#   nama_req_type.participant_types.create(name: "करांदा-आम") if nama_req_type.participant_types.where(name: "करांदा-आम").blank?
# end

# fouti_req_type = RequestType.where(name: "फौती").first rescue nil
# if fouti_req_type.present?
#   fouti_req_type.participant_types.create(name: "आवेदक") if fouti_req_type.participant_types.where(name: "आवेदक").blank?
#   fouti_req_type.participant_types.create(name: "फौत व्यक्ति") if fouti_req_type.participant_types.where(name: "फौत व्यक्ति").blank?
#   fouti_req_type.participant_types.create(name: "वारसान") if fouti_req_type.participant_types.where(name: "वारसान").blank?
# end

# bat_req_type = RequestType.where(name: "बटवारा").first rescue nil
# if bat_req_type.present?
#   bat_req_type.participant_types.create(name: "आवेदक") if bat_req_type.participant_types.where(name: "आवेदक").blank?
#   bat_req_type.participant_types.create(name: "मूल भू स्वामी") if bat_req_type.participant_types.where(name: "मूल भू स्वामी").blank?
#   bat_req_type.participant_types.create(name: "नए हिस्सेदार") if bat_req_type.participant_types.where(name: "नए हिस्सेदार").blank?
# end

ParticipantType.create(name: "आवेदक") if ParticipantType.where(name: "आवेदक").blank?
ParticipantType.create(name: "अनावेदक") if ParticipantType.where(name: "अनावेदक").blank?
ParticipantType.create(name: "करांदा-आम") if ParticipantType.where(name: "करांदा-आम").blank?
ParticipantType.create(name: "फौत व्यक्ति") if ParticipantType.where(name: "फौत व्यक्ति").blank?
ParticipantType.create(name: "वारसान") if ParticipantType.where(name: "वारसान").blank?
ParticipantType.create(name: "मूल भू स्वामी") if ParticipantType.where(name: "मूल भू स्वामी").blank?
ParticipantType.create(name: "नए हिस्सेदार") if ParticipantType.where(name: "नए हिस्सेदार").blank?