# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do 
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "logout" do
      link_to "Logout", admin_logout_path, method: :delete
    end
    @users = User.all
    @kyc = Kyc.all
    columns do
      column do
        panel "Users" do
          ul do
            para "Total users: #{User.count}"
            table_for @users do
              column :id
              column :firstname
              column :lastname
              column :email
              column :created_at
              column "KYC Status", :status do |user|
                if user.kyc && user.kyc.status.present?
                  status = user.kyc.status
                  status_tag(status, class: status == 'approved' ? :ok : :error, label: status.humanize, :editable => true)
                end
              end
                   
            end  
          end
        end
      end
      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content

end
