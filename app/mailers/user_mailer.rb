class UserMailer < ActionMailer::Base
  default from: '8600Chennai@thoughtworks.com'

  def asset_assigned_to_user(asset)
    @asset = asset
    mail :to => asset.owner.email,
         :subject => "You have been assigned a new #{asset.name}",
         :cc => admin_emails
  end

  def asset_assigned_to_project(asset)
    @asset = asset
    mail :to => asset.owner.email,
         :subject => "Your team has been assigned a new #{asset.name}",
         :cc => admin_emails
  end

  private
  def admin_emails
    User.admins.map(&:email)
  end
end
