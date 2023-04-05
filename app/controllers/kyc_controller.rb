class KycController < ApplicationController
    before_action :require_user_logged_in!, except: [:status] 

    def new
        @kyc = Kyc.find_by(user_id: Current.user.id)
        if @kyc.present?
            puts (@kyc.present?)
          redirect_to kyc_show_path(@kyc)
        else
          @kyc = Kyc.new
        end
    end
    
    def create
        @kyc = Kyc.find_by(user_id: Current.user.id)
        if @kyc.present?
            redirect_to kyc_show_path(@kyc)
        else    
            @kyc = Kyc.new(kyc_params)
            @kyc.user = Current.user
            if @kyc.save  
                if @kyc.status == "pending"
                    @kyc.update(status: :awaiting)
                    flash[:notice] = "License added successfully"
                    puts flash[:notice]
                    redirect_to kyc_show_path(@kyc), notice: "License added successfully"
                elsif @kyc.status == "awaiting"
                    redirect_to kyc_show_path(@kyc)
                else    
                    redirect_to root_path
                    flash[:notice] = "License added successfully"
                end    
            else
                if @kyc.status == "pending"
                    render :new
                else
                    render :show
                end    
            end   
        end         
    end    

    def show
        @kyc = Kyc.find_by(user_id: Current.user.id)
        render :show
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
