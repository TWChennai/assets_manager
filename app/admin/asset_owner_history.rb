ActiveAdmin.register AssetOwnerHistory do
  controller do
    before_filter only: :index do
      @per_page = 10_000_000 if request.format == 'text/csv'
    end
  end

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
    actions
  end

  csv do
    column :id
    column(:asset){|h| h.asset.try(&:name)}
    column(:owner){|h| h.owner.try(&:name)}
    column :event
    column :created_at
  end
end