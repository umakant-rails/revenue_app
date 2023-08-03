# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Role.create(name: 'Admin') if Role.where(name: 'Admin')
Role.create(name: 'Public User') if Role.where(name: 'Public User')

RequestType.create(name: "नामांतरण") if RequestType.where(name: "नामांतरण").blank?
RequestType.create(name: "बटवारा (पिता-पुत्र)") if RequestType.where(name: "बटवारा (पिता-पुत्र)").blank?
RequestType.create(name: "बटवारा (आपसी सहमति)") if RequestType.where(name: "बटवारा (आपसी सहमति)").blank?
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
  department.blank_forms.create(eng_name: "Income Certificate", hindi_name: "आय प्रमाण पत्र", group_name: 'Student') if department.blank_forms.where(eng_name: "Income Certificate", group_name: 'Student').blank?
  department.blank_forms.create(eng_name: "Domicile Certificate", hindi_name: "स्थाई निवास प्रमाण पत्र", group_name: 'Student') if department.blank_forms.where(eng_name: "Domicile Certificate", group_name: 'Student').blank?
  department.blank_forms.create(eng_name: "Cast Certificate", hindi_name: "जाति प्रमाण पत्र", group_name: 'Student') if department.blank_forms.where(eng_name: "Cast Certificate", group_name: 'Student').blank?
  department.blank_forms.create(eng_name: "PM Kisan Letter", hindi_name: "पी एम किसान फॉर्म", group_name: 'PM Kisan') if department.blank_forms.where(eng_name: "PM Kisan Letter", group_name: 'PM Kisan').blank?
  department.blank_forms.create(eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Ordersheet First", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Ordersheet Second", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Applicant Application", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Non Applicant Application", hindi_name: "अनावेदक आवेदन", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Non Applicant Application", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Applicant Affidavit", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Non Applicant Affidavit", hindi_name: "अनावेदक शपथ पत्र", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Non Applicant Affidavit", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Ishtihar", hindi_name: "इश्तिहार", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Ishtihar", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Kathan", hindi_name: "कथन", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Kathan", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Talwana", hindi_name: "तलवाना", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Talwana", group_name: "Namantaran").blank?
  department.blank_forms.create(eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन", group_name: "Namantaran") if department.blank_forms.where(eng_name: "Patwari Prativedan", group_name: "Namantaran").blank?

  department.blank_forms.create(eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम", group_name: "Fouti") if department.blank_forms.where(eng_name: "Ordersheet First", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय", group_name: "Fouti") if department.blank_forms.where(eng_name: "Ordersheet Second", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन", group_name: "Fouti") if department.blank_forms.where(eng_name: "Applicant Application", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र", group_name: "Fouti") if department.blank_forms.where(eng_name: "Applicant Affidavit", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Ishtihar", hindi_name: "इश्तिहार", group_name: "Fouti") if department.blank_forms.where(eng_name: "Ishtihar", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Talwana", hindi_name: "तलवाना", group_name: "Fouti") if department.blank_forms.where(eng_name: "Talwana", group_name: "Fouti").blank?
  department.blank_forms.create(eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन", group_name: "Fouti") if department.blank_forms.where(eng_name: "Patwari Prativedan", group_name: "Fouti").blank?
end