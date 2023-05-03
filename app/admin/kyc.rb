ActiveAdmin.register Kyc do
    permit_params :id, :status, :license_number
    
    form do |f|
        f.inputs "KYC Details" do
        f.input :status, as: :select, collection: Kyc.statuses.keys
        f.input :license_number, input_html: { value: f.object.license_number }, readonly: true
        end
        f.actions do
          f.action :submit, label: "Update KYC Status", url: admin_sessions_path, notice: "KYC status was successfully updated."
        end
    end
    def update
        @kyc = Kyc.find(params[:id])
        if @kyc.update(kyc_params)
          redirect_to admin_dashboard_path, notice: "KYC status was successfully updated."
        else
          render :edit
        end
      end
    
      def kyc_params
        params.require(:kyc).permit(:status, :license_number, :user_id)
      end
end