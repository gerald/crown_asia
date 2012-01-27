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

    RawMaterialType.create(:name => "CMR", :code => "CMR")
    RawMaterialType.create(:name => "CMP", :code => "CMP")
    RawMaterialType.create(:name => "CSS", :code => "CSS")
    RawMaterialType.create(:name => "CSL", :code => "CSL")
    RawMaterialType.create(:name => "COL", :code => "COL")
  end
end