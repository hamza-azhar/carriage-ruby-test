require 'rails_helper'

RSpec.describe Comment, type: :model do
	it { should have_many(:replies).dependent(:destroy).class_name('Comment').with_foreign_key('comment_id').dependent(:destroy) }
	it { should belong_to(:comment).class_name('Comment').with_foreign_key('comment_id').optional }
	it { should belong_to(:card).optional }


end