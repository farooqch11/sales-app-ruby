ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #

    panel "Recent Companies" do
      table_for Company.last(5) do
        column :company_name do |c|
          link_to(c.company_name, admin_company_path(c))
        end
        column :owner
        column :country
        column :logo
        column :created_at
        column "Email" do |reaction|
          reaction.owner.email
        end
      end
    end

    columns do
      column do
        panel "Info" do
          para "Welcome to Managehub360 Admin Panal."
        end
      end
    end
  end # content
end
