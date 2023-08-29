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
Department.create(eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी") if Department.where(eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी").blank?

revenue_forms = [
  {eng_name: "Income Certificate", hindi_name: "आय प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Domicile Certificate", hindi_name: "स्थाई निवास प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Cast Certificate", hindi_name: "जाति प्रमाण पत्र (ओ बी सी)", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  # {eng_name: "Cast Certificate SCST", hindi_name: "जाति प्रमाण पत्र (अजा/अजजा)", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Digital Cast Certificate", hindi_name: "डिजिटल जाति प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Birth And Death Certificate", hindi_name: "जन्म मृत्यु प्रमाण पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "Sambal Form", hindi_name: "सम्बल आवेदन पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "EWS Form", hindi_name: "ई डब्ल्यू एस आवेदन पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},
  {eng_name: "BPL Form", hindi_name: "बी पी एल आवेदन पत्र", section_hindi: 'लोकसेवा फॉर्म', section: 'Loksewa Form'},


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

  {eng_name: "Seemankan Form1", hindi_name: "सीमांकन फॉर्म - प्रथम", section_hindi: "सीमांकन फॉर्म", section: 'Seemankan Form'},
  {eng_name: "Seemankan Form2", hindi_name: "सीमांकन फॉर्म - द्वितीय", section_hindi: "सीमांकन फॉर्म", section: 'Seemankan Form'},
  {eng_name: "Seemankan Form3", hindi_name: "सीमांकन फॉर्म - तृतीय", section_hindi: "सीमांकन फॉर्म", section: 'Seemankan Form'},

  {eng_name: "Form C", hindi_name: "फॉर्म सी", section_hindi: "अन्य फॉर्म", section: 'Other Form'},
  {eng_name: "Crop Sowing", hindi_name: "फसल बुआई प्रमाण पत्र", section_hindi: "अन्य फॉर्म", section: 'Other Form'},
  {eng_name: "Lease Land Sell Permission Form", hindi_name: "पट्टा भूमि विक्रय हेतु अनुमति आवेदन", section_hindi: "अन्य फॉर्म", section: 'Other Form'},
  {eng_name: "Land Selling Ikrarnama Form", hindi_name: "विक्रय इकरारनामा फॉर्म", section_hindi: "अन्य फॉर्म", section: 'Other Form'},

]

govt_emp_forms = [
  {eng_name: "Earning Leave Application Form", hindi_name: "अर्जित अवकाश आवेदन फॉर्म", section_hindi: "सरकारी कर्मचारी फॉर्म", section: 'Govt Employee Form'},
  {eng_name: "Form 16", hindi_name: "फॉर्म 16", section_hindi: "सरकारी कर्मचारी फॉर्म", section: 'Govt Employee Form'},
  {eng_name: "Medical Leave Form 4", hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल अवकाश)", section_hindi: "सरकारी कर्मचारी फॉर्म", section: 'Govt Employee Form'},
  {eng_name: "Medical Leave Form 3", hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल फिटनेस)", section_hindi: "सरकारी कर्मचारी फॉर्म", section: 'Govt Employee Form'}\

]


rev_dept = Department.where(eng_name: "revenue", hindi_name: "राजस्व").first
if rev_dept.present?
  revenue_forms.each do | form | 
    rev_dept.blank_forms.create(form) if rev_dept.blank_forms.where(form).blank?
  end
end

govt_emp =  Department.where(eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी").first
if govt_emp.present?
  govt_emp_forms.each do | form | 
    govt_emp.blank_forms.create(form) if govt_emp.blank_forms.where(form).blank?
  end 
end