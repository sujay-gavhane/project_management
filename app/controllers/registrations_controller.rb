class RegistrationsController < Devise::RegistrationsController

  def update
    self.resource.update_attributes(registrations_params)
    bypass_sign_in resource, scope: resource_name
    respond_with resource, location: after_update_path_for(resource)
  end

  private

  def registrations_params
    params.require(:employee).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
