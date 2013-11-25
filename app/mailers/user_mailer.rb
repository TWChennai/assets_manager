class UserMailer < ActionMailer::Base
  default from: '8600Chennai@thoughtworks.com',
          cc: %w(selvakn+oam@thoughtworks.com gopinatj@thoughtworks.com)

  def asset_assigned_to_user(asset)
    @asset = asset
    mail :to => asset.owner.email, :subject => "You have been assigned a new #{asset.name}"
  end

  def asset_assigned_to_project(asset)
    @asset = asset
    mail :to => asset.owner.email, :subject => "Your team has been assigned a new #{asset.name}"
  end
end
