class UserMailer < ActionMailer::Base
  default :from => 'accessoripod@thoughtworks.com',
          :cc   => ->(_) { admin_emails }

  def asset_assigned_to_user(asset)
    @asset = asset
    mail :to => asset.owner.email,
         :subject => "You have been assigned a new #{asset.name}"
  end

  def asset_assigned_to_project(asset)
    @asset = asset
    mail :to => asset.owner.email,
         :subject => "Your team has been assigned a new #{asset.name}"
  end

  def asset_unassigned(asset, previous_owner)
    @asset = asset
    @previous_owner = previous_owner
    mail :to => previous_owner.email,
         :subject => "You have returned #{asset.name}"
  end

  private
  def admin_emails
    User.admins.map(&:email)
  end
end
