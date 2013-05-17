namespace :finished_goods do
  desc 'Populate soft pvc'
  task :populate_soft_pvc => :environment do
    FinishedGood.update_all("soft_pvc = 1")
  end
end
