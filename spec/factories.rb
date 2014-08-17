FactoryGirl.define do 
	factory :user do
		sequence(:name)  {|n| "Person #{n}"}
		sequence(:email) {|n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		
		factory :admin do
			admin true
		end
	end
=begin	
	factory :admin, class: User do
		sequence(:name)  {|n| "Person #{n}"}
		sequence(:email) {|n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		admin true
	end
=end
	factory :micropost do
		content "Lorem ipsum"
		user
	end
end