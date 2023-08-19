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

revenue_forms = [
  {eng_name: "Income Certificate", hindi_name: "आय प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Domicile Certificate", hindi_name: "स्थाई निवास प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Cast Certificate", hindi_name: "जाति प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Digital Cast Certificate", hindi_name: "डिजिटल जाति प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Birth And Death Certificate", hindi_name: "जन्म मृत्यु प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  

  {eng_name: "Applicant Application", hindi_name: "आवेदक का आवेदन", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},
  {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},
  {eng_name: "Tehsildar Letter", hindi_name: "तहसीलदार पत्र", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},
  {eng_name: "Nayab Tehsildar Letter", hindi_name: "नायब तहसीलदार पत्र", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},
  {eng_name: "Patwari Prativedan Ineligiblity", hindi_name: "पटवारी प्रतिवेदन (अपात्रता)", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},
  {eng_name: "Aadhar Seeding NPCI Form", hindi_name: "आधार लिंकिंग/एन पी सी आई फॉर्म", section_hindi: 'पी एम किसान फॉर्म', section: 'PM Kisan Form'},

  {eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Non Applicant Application", hindi_name: "अनावेदक आवेदन", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Non Applicant Affidavit", hindi_name: "अनावेदक शपथ पत्र", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Ishtihar", hindi_name: "इश्तिहार", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Kathan", hindi_name: "कथन", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Talwana", hindi_name: "तलवाना", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},
  {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन", section_hindi: "नामांतरण फॉर्म", section: 'Namantaran Form'},

  {eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Ishtihar", hindi_name: "इश्तिहार", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Talwana", hindi_name: "तलवाना", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},
  {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन", section_hindi: "फौती फॉर्म", section: 'Fouti Form'},

  {eng_name: "Form C", hindi_name: "फॉर्म सी", section_hindi: "अन्य फॉर्म", section: 'Other Form'}

]

if department.present?
  revenue_forms.each do | form | 
    department.blank_forms.create(form) if department.blank_forms.where(form).blank?
  end
end