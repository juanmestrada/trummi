# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#   	# identified_by :current_person
#     identified_by :current_user

#   	def connect
#   		# self.current_person = find_current_user
#       self.current_user = find_verified_user
#   	end

#   	def disconnect

#   	end

#   	protected
#   	# def find_current_user
#   	# 	if current_person = User.find_by(id: cookies.signed[:user_id])
#   	# 		current_person
#   	# 	else
#   	# 		reject_unauthorized_connection
#   	# 	end
#   	# end
#     def find_verified_user # this checks whether a user is authenticated with devise
#       if verified_user = env['warden'].user
#         verified_user
#       else
#         reject_unauthorized_connection
#       end
#     end

#   end
# end
