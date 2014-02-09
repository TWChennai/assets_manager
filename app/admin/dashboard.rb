ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Assets individuals usage summary" do
          table_for Asset.indivduals_usage_summary do
            column "Holder Name" do |entry|
              link_to entry.user_name, admin_user_path(entry.user_id)
            end
            column "Asset", :asset_name
            column "Count", :count
          end

        end
      end

      column do
        panel "Common assets usage summary" do
          table_for Asset.common_usage_summary do
            column "Holder Name" do |entry|
              link_to entry.user_name, admin_user_path(entry.user_id)
            end
            column "Asset", :asset_name
            column "Count", :count
          end
        end
      end
    end
  end
end