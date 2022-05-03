json.tags do 
	json.array!(@t) do |tag|
		json.name tag.name
		json.url tag_path(tag)
	end
end

json.profiles do 
	json.array!(@prof) do |profile|
		json.img profile.image1.url
		json.name profile.name
		json.url profile_path(profile)
	end
end