json.array! @notifications do |notification|
	json.id notification.id
	# json.recipient notification.recipient
	json.actor notification.actor.profile.name
	json.actorimg notification.actor.profile.image1.url(:thumb)
	json.action notification.action
	json.notifiable_id notification.notifiable_id 
	json.notifiable do #notifiable.notifiable
		json.type "your #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
	end
	json.url polymorphic_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end