class SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      sign_in(resource_name, resource)
      respond_to do |format|
        format.js {
          flash[:notice] = "Signed in successfully."
          render :template => "remote_content/devise_success_sign_up.js.erb"
          flash.discard
        }
      end
    else
      respond_to do |format|
        format.js {
          flash[:alert] = "Incorrect username or password"
          render :template => "remote_content/devise_errors.js.erb"
          flash.discard
        }
      end
    end
  end

end