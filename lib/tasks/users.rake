namespace :users do
  desc 'Generate first user'
  task :generate_first_user => :environment do
    u = User.new
    u.username = "s.leevillanueva"
    u.password = "passw0rd"
    u.email = "pipay04@yahoo.com"
    u.first_name = "Stephanie"
    u.last_name = "Lee Vilanueva"
    u.roles << Role.find_by_name("admin")
    u.save!
  end
end