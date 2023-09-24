# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

templates = CSV.parse(File.read('db/seeds/templates.csv'), headers: true)
Template.upsert_all(templates.map(&:to_h), unique_by: :id)

template_stats = CSV.parse(File.read('db/seeds/template_stats.csv'), headers: true)
TemplateStat.delete_all
TemplateStat.upsert_all(template_stats.map(&:to_h))

industries = CSV.parse(File.read('db/seeds/industries.csv'), headers: true)
Industry.upsert_all(industries.map(&:to_h), unique_by: :id)

advanced_data_no_industry = CSV.parse(File.read('db/seeds/advanced_data_no_industry.csv'), headers: true)
advanced_data_with_industry = CSV.parse(File.read('db/seeds/advanced_data_with_industry.csv'), headers: true)
AdvancedMetric.delete_all
AdvancedMetric.upsert_all(advanced_data_no_industry.map(&:to_h))
AdvancedMetric.upsert_all(advanced_data_with_industry.map(&:to_h))

company_length_data = CSV.parse(File.read('db/seeds/company_length_data.csv'), headers: true)
CompanyLengthMetric.delete_all

company_length_data = company_length_data.map do |row|
  min_length, max_length = row['company_name_length'].split('-').map(&:to_i)
  {
    min_length:,
    max_length:,
    extended: max_length.nil?,
    template_name: row['template_name'],
    sales_count: row['sales_count']
  }
end

CompanyLengthMetric.upsert_all(company_length_data)
