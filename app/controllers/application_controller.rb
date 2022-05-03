class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
  	before_action :authenticate_user!
  	# before_action :check_profile_presence

  	

	protected

	def check_profile_presence

    	if !Profile.exists?(user_id: current_user.id)
        	redirect_to welcome_path
    	end
    end

    def check_isdisabled
    	redirect_to(settings_path, flash: { alert: "Your profile is disabled!" }) if (current_user.profile != nil) && (current_user.profile.isdisabled) 
    end

	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :dob])

    	devise_parameter_sanitizer.permit(:sign_in) do |user_params|
		    user_params.permit(:isunderage)
		end
	end

	def after_sign_in_path_for(resource_or_scope)
		if current_user.profile != nil
			current_user.profile.update_attribute(:age, current_user.age(current_user.dob))
			posts_path
		else
			if current_user.age(current_user.dob) >= 18 
				current_user.update_attribute(:isunderage, false)
			end
			
			new_profile_path
		end
	end

	def after_sign_out_path_for(resource_or_scope)
		new_user_session_path
	end

end
