class UserMailer < ActionMailer::Base
  default from: '8600Chennai@thoughtworks.com'

  def asset_assigned(asset)
    mail :to => asset.owner_email, :subject => 'You have been assigned a new asset'
  end
end
