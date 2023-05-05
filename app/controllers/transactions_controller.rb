class TransactionsController < ApplicationController
    attr_accessor :sender_id, :receiver_id, :amount, :receiver_email
    before_action :require_user_logged_in!
    before_action :set_user
    before_action :set_wallet
    before_action :set_balance, only: [:show, :destroy, :edit, :update]
    before_action :require_kyc_exists, only: [:index, :show, :edit, :update]
    before_action :require_kyc_approved, only: [:index, :show, :edit, :update]
    before_action :require_accept_terms, only: [:index, :show, :edit, :update]

    def index
        user = Current.user
        @transactions_sender=Transaction.where(sender_id: user.id).pluck(:amount, :receiver_email, :created_at, :currency)
        @transactions_receiver=Transaction.where(receiver_id: user.id).pluck(:amount, :sender_email, :created_at, :currency)
        render 'index'
    end

    def new
        @transaction=Transaction.new
    end

    def create
        s_id=Current.user.id
        @receiver=User.find_by(email: params[:transaction][:email])
        if @receiver
            r_id=User.find_by(email: params[:transaction][:email]).id
            @transaction=Transaction.new(sender_id: s_id, receiver_id: r_id, amount: params[:transaction][:amount], receiver_email: params[:transaction][:email], sender_email: Current.user.email, currency: params[:transaction][:currency]   )
            @balances = @wallet.balances
            if @wallet && @balances.any? { |balance| balance.currency == params[:transaction][:currency] }
                #puts("Currency already exist !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                if @balances.any? { |balance| balance.currency == params[:transaction][:currency] && balance.value < params[:transaction][:amount].to_f }
                    #puts("Not sufficient balance -------------------------------------------------balance.value", @balances.find_by(currency: params[:transaction][:currency] )[:value])
                    redirect_to wallet_balances_path, alert: "You need to add sufficient balance for this currency first"
                else
                    @balance = @balances.find_by(currency: params[:transaction][:currency] )
                    # puts @balance.value.to_f, "****"
                    #@balance.decrement(:value, params[:transaction][:amount].to_f)
                    #if @balances.update(value: @balance.value-params[:transaction][:amount].to_f)
                    new_val = ((@balance.value*100-params[:transaction][:amount].to_f*100).to_i)/100.0  
                    #puts "NEW VAL is ",new_val.to_f
                    
                    ###########UPDATIMNG
                    @receiver_wallet=@receiver.wallet
                    if @receiver_wallet.present?
                        #puts "Receiver wallet present!!"
                    else
                        @receiver_wallet = Wallet.new(user_id: @receiver.id)
                        if @receiver_wallet.save
                            #puts "Receiver wallet created!!"
                        end
                    end
                    @receiver_balances=@receiver_wallet.balances
                    @receiver_balance = @receiver_balances.find_by(currency: params[:transaction][:currency] )
                    if @receiver_balance.present?
                        # puts "Receiver balance present"
                        if @receiver_balance.update(value: @receiver_balance.value +  params[:transaction][:amount].to_f)
                            # puts "Successful"
                            if(new_val.abs < 0.01)
                                new_val=0.0
                                @balance.destroy
                                if  @transaction.save
                                    redirect_to transactions_path, notice: "Transaction created!"
                                else
                                    flash[:alert] = "Transaction not updated. Coding error. Sorry for the incompetance!"
                                    render :new     
                                end
                            elsif @balance.update(value: new_val.to_f)
                                if  @transaction.save
                                    redirect_to transactions_path, notice: "Transaction created!"
                                else
                                    flash[:alert] = "Transaction not updated. Coding error. Sorry for the incompetance!"
                                    render :new     
                                end
                            else
                                redirect_to transactions_path, notice: "Some error occured. Sorry!!!"
                            end
                        else
                            # puts "Not able to update his balance"
                            redirect_to transactions_path, notice: "Some error occured. Sorry!!!"
                        end
                    else
                        # puts "No receiver balance!!"
                        @receiver_balance = @receiver_wallet.balances.new(value: params[:transaction][:amount].to_f, wallet_id: @receiver.wallet.user_id,  currency: params[:transaction][:currency] )
                        if @receiver_balance.save
                            # puts "Created receiver balances"
                            if(new_val.abs < 0.01)
                                new_val=0.0
                                @balance.destroy
                                if  @transaction.save
                                    redirect_to transactions_path, notice: "Transaction created!"
                                else
                                    flash[:alert] = "Transaction not updated. Coding error. Sorry for the incompetance!"
                                    render :new     
                                end
                            elsif @balance.update(value: new_val.to_f)
                                if  @transaction.save
                                    redirect_to transactions_path, notice: "Transaction created!"
                                else
                                    flash[:alert] = "Transaction not updated. Coding error. Sorry for the incompetance!"
                                    render :new     
                                end
                            else
                                redirect_to transactions_path, notice: "Some other error occured. Sorry!!!"
                            end
                        else
                            redirect_to transactions_path, alert: "Receiver has not added any card as of now. Transaction not possible. Sorry!!!"
                            # puts @receiver_balance.errors.full_messages
                            # puts "Receiver balance not created! some error!!"
                        end
                    end

                    #@balances.find_by(currency: params[:transaction][:currency] ).value=@balances.find_by(currency: params[:transaction][:currency] )[:value]-params[:transaction][:amount].to_f
                    
                    # puts("*****************************************8")
                end
            else
                # puts("Currency does not exist!!")
                redirect_to wallet_balances_path, alert: "You need to add this currency first"
            end
        else
            redirect_to transactions_path, alert: "Receiver's email is incorrect. No such user. Check email id and try again."
        end

        
    end

    

    private
    def transaction_params
        params.require(:transaction).permit(:email, :currency, :amount)
    end

    def set_user
      @user = Current.user
    end 
  
    def set_wallet
      @wallet = @user.wallet 
      if !@wallet 
        redirect_to new_wallet_path, alert: "create a wallet now" 
      end 
    end 
  
    def set_balance
      @balance = @wallet.balances.find_by(id: params[:id])
    end

    def require_kyc_exists
        @user = Current.user
        unless @user.kyc.present?
          flash[:alert] = "KYC must be approved to access this page"
          redirect_to kyc_new_path
        end
    end
    def require_kyc_approved
        @user = Current.user
        unless @user.kyc.status == "approved"
          flash[:alert] = "KYC status must be approved to access this page"
          redirect_to kyc_show_path
        end
    end
    def require_accept_terms
      if !@user.terms_of_service
        redirect_to terms_path, alert: "please accept our terms first" and return 
      end 
    end 
end