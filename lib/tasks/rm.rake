namespace :rm do
  desc 'Migrate issued department to issued to'
  task :migrate_issued_department => :environment do
    RawMaterialTransaction.all(:conditions => "issued_department_id IS NOT NULL").each do |rmt|
      rmt.update_attribute(:issued_to_type, "Department")
      rmt.update_attribute(:issued_to_id, rmt.issued_department_id)
    end
  end
end
