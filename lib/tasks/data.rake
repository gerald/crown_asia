namespace :data do
  desc 'Setup data'
  task :setup_initial_data => :environment do
    UnitOfMeasure.create(:code => "KG")
    UnitOfMeasure.create(:code => "PC")
    UnitOfMeasure.create(:code => "ROLL")
    UnitOfMeasure.create(:code => "REAM")
    UnitOfMeasure.create(:code => "BOTTLE")
    UnitOfMeasure.create(:code => "BUNDLE")
    
    Department.create(:name => "Warehouse & Physical Distribution", :code => "WPD")
    Department.create(:name => "Production & Maintenance", :code => "PM")
    Department.create(:name => "Quality Assurance/R&D", :code => "QARD")
    Department.create(:name => "Management", :code => "MGT")

    RawMaterialType.create(:code => "CMR")
    RawMaterialType.create(:code => "CMP")
    RawMaterialType.create(:code => "CSS")
    RawMaterialType.create(:code => "CSL")
    RawMaterialType.create(:code => "COL")
  end
  
  desc 'Setup roles'
  task :setup_roles => :environment do
    Role.create(:name => "Administrator", :code => "admin")
    Role.create(:name => "Department Head", :code => "department_head")
    Role.create(:name => "Supervisor", :code => "supervisor")
    Role.create(:name => "Admin Assistant", :code => "admin_assistant")
    Role.create(:name => "Encoder", :code => "encoder")
  end
end