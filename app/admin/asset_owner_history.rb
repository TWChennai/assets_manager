ActiveAdmin.register AssetOwnerHistory do
  actions :all, :except => [:destroy, :new, :edit]

  filter :asset
  filter :created_at
  filter :event, :as => :select, :collection => AssetOwnerHistory::EVENTS::ALL

  index do
    column :id
    column :asset
    column :owner
    column :event
    column :created_at
    default_actions
  end

end
