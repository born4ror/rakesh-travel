class RegistrationsController < Devise::RegistrationsController
  
  def create
    build_resource(sign_up_params)
    if resource.save
      respond_to do |format|
        format.html {
          yield resource if block_given?
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        }
        format.js {
          flash[:notice] = "Signed up successfully."
          render :template => "remote_content/devise_success_sign_up.js.erb"
          flash.discard
          sign_up(resource_name, resource)
        }
      end
    else
      respond_to do |format|
        format.html {
          clean_up_passwords resource
          respond_with resource
        }
        format.js {
          flash[:alert] = @user.errors.full_messages.to_sentence
          render :template => "remote_content/devise_errors.js.erb"
          flash.discard
        }
      end
    end
  end

  protected
  # def after_update_path_for resource
  #   edit_user_registration_path
  # end

  # def after_sign_up_path_for(resource)
  #   root_path
  # end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dob, :company_name, :avatar)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :dob, :company_name, :avatar)
  end

  def update_resource(resource, params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end