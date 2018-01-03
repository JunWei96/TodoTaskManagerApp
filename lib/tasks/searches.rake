desc "Remove searches older than a hour"
task :remove_old_searches => :environment do
  AdvancedSearch.where("created_at < ?", 1.hour.ago).delete_all
end
