namespace :data do
  desc 'Setup data'
  task :setup_initial_data => :environment do
    UnitOfMeasure.create(:name => "Kilogram", :code => "KG")
    UnitOfMeasure.create(:name => "Piece", :code => "PC")
    UnitOfMeasure.create(:name => "Roll", :code => "ROLL")
    UnitOfMeasure.create(:name => "Ream", :code => "REAM")
    UnitOfMeasure.create(:name => "Bottle", :code => "BOTTLE")
    UnitOfMeasure.create(:name => "Bundle", :code => "BUNDLE")
    
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