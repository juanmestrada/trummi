module ApplicationHelper

	def gravatar_for(user, options = { size: 80 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, class: "img-wrapper")
	end

	def emojify(content)
	  h(content).to_str.gsub(/:([\w+-]+):/) do |match|
	    if emoji = Emoji.find_by_alias($1)
	      %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
	    else
	      match
	    end
	  end.html_safe if content.present?
	end

	# def online_status(user)
	# 	content_tag :span, user.profile.name, class: "user-#{user.id} online_status #{'online' if user.online?}"
	# end
	
	def image_generator(height:, width:)
		"http://placehold.it/#{height}x#{width}"
	end

	def new_conv_or_pm?(user_id)
		# if Conversation.between(current_user.profile.id, user_id).exists? 
		# 	@conexist = true
		# else
		# 	@conexist = false
		# end

		convo = Conversation.between(current_user.profile.id, user_id)[0]
		if convo && (convo.author == current_user.profile) && !convo.personal_messages.last.author_destroy
			
			return false
		elsif convo && (convo.receiver == current_user.profile) && !convo.personal_messages.last.receiver_destroy
			
			return false
		else
			
			return true
		end
	end

end
