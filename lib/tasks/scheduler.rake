namespace :scheduler do

  desc "Send email for borrowed items"
  task reminder: :environment do

    Asset.where(status: Asset::Status::ASSIGNED).each do |asset|
      UserMailer.asset_borrowed_not_returned(asset).deliver!
    end

  end

end
