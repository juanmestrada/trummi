class NotificationsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_profile_presence

	def index
		if !current_user.profile.isdisabled
			@notifications = Notification.where(recipient: current_user).unread
		end
	end

	def mark_as_read
		if !current_user.profile.isdisabled
			@notifications = Notification.where(recipient: current_user).unread
			@notifications.update_all(read_at: Time.zone.now)
			render json: {success: true}
		end
	end
end