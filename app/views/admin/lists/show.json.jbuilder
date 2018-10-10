json.success true
json.list do
	json.title @list.title
	if @list.cards.present?
		json.cards do
      json.array! @list.cards.each do |card|
        json.title card.title
        json.description card.description
      end
    end	
	end
end