ActiveAdmin.register User do
  permit_params :id, :email, :firstname, :lastname, kyc_attributes: [:id, :status]
  # action_item :edit_status, only: :edit do
  #   link_to "Edit Status", custom_path(resource)
  # end
  index do
    selectable_column
    id_column
    column :email
    column :firstname
    column :lastname
    column :created_at
    actions
  end
  form do |f|
    f.semantic_errors
    f.inputs "User Details" do
      f.input :email
      f.input :firstname
      f.input :lastname
    end
    # f.inputs "KYC Details" do
    #   f.fields_for :kyc, @user.kyc || @user.build_kyc do |kyc_f|
    #     kyc_f.input :status, as: :select, collection: Kyc.statuses.keys
    #   end
    # end
    f.actions
  end
  controller do
    def update
      @user = User.find(params[:id])
      @kyc = @user.kyc
      if @kyc.update(kyc_params)
        print(kyc_params)
        redirect_to admin_users_path, notice: "User was successfully updated."
      else
        render :edit
      end
    end
    # def edit
    #   @user = User.find(params[:id])
    #   @user.build_kyc if @user.kyc.nil?
    #   super
    # end
    private
    def user_params
      params.require(:user).permit(:id, :email, :firstname, :lastname, kyc_attributes: [:id, :status])
    end
    def kyc_params
      params.require(:kyc).permit(:id, :status)
    end
  end
end



