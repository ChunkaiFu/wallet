class Admin::KycsController <  ApplicationController
    def update
        @kyc = Kyc.find(params[:id])
        if(session[:admin_authenticated])
          if @kyc.update(kyc_params)
            redirect_to admin_dashboard_path, notice: "KYC status updated successfully."
          else
            redirect_to admin_sessions_path(@kyc), alert: "Failed to update KYC status."
          end
        end
    end
  end
  