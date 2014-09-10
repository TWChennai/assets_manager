# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?

  User.create name: 'Test User', employee_id: 1234

  Project.create name: 'Test Project', email: 'test@test.com', location: Location.first

  AssetType.create name: 'Test Asset Type' do |asset_type|
    Brand.create name: 'Test Brand' do |brand|
      Asset.create bar_code: '123456789', asset_type: asset_type, status: Asset::Status::IN_STOCK,
        description: 'Test Asset Description', brand: brand, location: Location.first
    end
  end

end
