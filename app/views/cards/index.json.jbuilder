json.success true
debugger
if @lists.present?
	json.lists @lists.each do |list|
		json.title list.title
		if list.cards.present?
			json.cards do
	      json.array! list.cards.each do |card|
	        json.title card.title
	        json.description card.description
	      end
	    end	
		end
	end
else
	json.lists []
end