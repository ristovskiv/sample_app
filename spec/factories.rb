FactoryGirl.define do 
	factory :user do
		name "Vlatko Ristovski"
		email "vlatko@exaple.com"
		password "foobar"
		password_confirmation "foobar"
	end
end