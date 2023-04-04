class KycController < ApplicationController
    before_action :require_user_logged_in! 

    def new
        @kyc = Kyc.new
    end
    
    def create
        @kyc = Kyc.new(kyc_params)
        @kyc.user = Current.user
        if @kyc.save
            puts @kyc.status
            if @kyc.status == "awaiting"
                render :show
            else    
                redirect_to root_path
                flash[:notice] = "License added successfully"
            end    
        else
            if @kyc.status == "pending"
                render :new
                puts @kyc.status
                puts @kyc.errors.full_messages
                @kyc.status = "awaiting"
                puts @kyc.status
                puts ("status changed")
            else
                render :show
                puts ("status changed")
            end    
        end        
    end    

    def status
        @kyc = Kyc.find_by(user_id: Current.user.id)
        if @kyc.present?
          render :status
        else
          redirect_to new_kyc_path, notice: 'Please complete your KYC information.'
        end
    end

    private
    def kyc_params
        params.require(:kyc).permit(:license_number, :status)
    end    
end
