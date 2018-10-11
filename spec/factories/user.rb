FactoryBot.define do

  factory :user do
    email 'admin@example.com'
    password '12345678'
    username 'admintest'
    roles { [ Role.find_or_create_by(name: 'admin') ] }
    roles { [ Role.find_or_create_by(name: 'registered_customer') ] }     
    factory :admin do      
      roles { [ Role.find_or_create_by(name: 'admin')  ] }    
    end     
    
    factory :member do      
      roles {  [ Role.find_or_create_by(name: 'member') ] }    
    end  
  end

end
