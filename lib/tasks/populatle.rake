require 'simple_xlsx_reader'

desc 'Populate models with sample data'
task :populate_villages => [ :environment ] do

  workbook = SimpleXlsxReader.open '/home/rails/rails_work/revenue_app/lib/tasks/villagemaster.xlsx'
  worksheets = workbook.sheets
  puts "Found #{worksheets.count} worksheets"

  worksheets.each do |worksheet|
    num_rows = 0
    worksheet.rows.each do |row|
      # if row[1] == 'Sagar'
        halka_number, halka_name = row[5].split("-")
        lgd_code = row[9]
        
        Village.create(                                                  
          district: row[0].index("-").present? ? row[0][row[0].index("-")+1..row[0  ].length] : row[0],                                                
          district_eng: row[1],                                            
          tehsil: row[2].index("-").present? ? row[2][row[2].index("-")+1..row[2].length] : row[2],                                                  
          tehsil_eng: row[3],                                              
          ri: row[4].index("-").present? ? row[4][row[4].index("-")+1..row[4].length] : row[4],                                                      
          halka_number: halka_number.to_i.to_s,                                            
          halka_name: halka_name,                                                                                         
          village: row[6].index("-").present? ? row[6][row[6].index("-")+1..row[6].length] : row[6],                                                 
          village_eng: row[7],                                             
          bhucode_lr: row[8],                                              
          lgd_code: row[9],                                                
          total_khasra: row[10].to_i,
          total_area: row[11],
        ) if Village.where(lgd_code: lgd_code).blank?
        num_rows = num_rows + 1
        puts "#{num_rows} is entered"
      # end
    end
  end


end
