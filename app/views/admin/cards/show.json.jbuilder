json.success true
json.list do
	json.title @card.title
	json.description @card.description
	if @card.present? && @card.comments.present?
		json.cards do
      json.array! @card.comments.first(3).each do |comment|
        json.content card.content
        json.description card.description
      end
    end	
	end
end