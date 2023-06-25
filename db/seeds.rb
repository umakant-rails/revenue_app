# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

RequestType.create(name: "नामांतरण") if RequestType.where(name: "नामांतरण").blank?
RequestType.create(name: "बटवारा") if RequestType.where(name: "बटवारा").blank?
RequestType.create(name: "फौती") if RequestType.where(name: "फौती").blank?

# ParticipantType.create(name: "आवेदक") if ParticipantType.where(name: "आवेदक").blank?
ParticipantType.create(name: "क्रेता") if ParticipantType.where(name: "क्रेता").blank?
ParticipantType.create(name: "विक्रेता") if ParticipantType.where(name: "विक्रेता").blank?
ParticipantType.create(name: "करांदा-आम") if ParticipantType.where(name: "करांदा-आम").blank?
ParticipantType.create(name: "फौत व्यक्ति") if ParticipantType.where(name: "फौत व्यक्ति").blank?
ParticipantType.create(name: "वारसान") if ParticipantType.where(name: "वारसान").blank?
ParticipantType.create(name: "मूल भू स्वामी") if ParticipantType.where(name: "मूल भू स्वामी").blank?
ParticipantType.create(name: "नए हिस्सेदार") if ParticipantType.where(name: "नए हिस्सेदार").blank?
ParticipantType.create(name: "मूल भू स्वामी एवं हिस्सेदार") if ParticipantType.where(name: "मूल भू स्वामी एवं हिस्सेदार").blank?


Department.create(eng_name: "revenue", hindi_name: "राजस्व") if Department.where(eng_name: "revenue", hindi_name: "राजस्व").blank?

department = Department.where(eng_name: "revenue", hindi_name: "राजस्व").first
if department.present?
  department.blank_forms.create(eng_name: "income certificate", hindi_name: "आय प्रमाण पत्र") if department.blank_forms.where(eng_name: "income certificate").blank?
  department.blank_forms.create(eng_name: "domicile certificate", hindi_name: "स्थाई निवास प्रमाण पत्र") if department.blank_forms.where(eng_name: "domicile certificate").blank?
  department.blank_forms.create(eng_name: "cast certificate", hindi_name: "जाति प्रमाण पत्र") if department.blank_forms.where(eng_name: "cast certificate").blank?
end