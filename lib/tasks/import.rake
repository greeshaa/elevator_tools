require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do
CSV.foreach('my_temp/test.csv', :headers => true) do |row|
Inspection.create!(row.to_hash)
end
end