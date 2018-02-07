module Helpers

  def sign_up(username: 'reenz', email: 'reenz@test.com', password: 'password')
    visit('/')
    fill_in :username,  with: username
    fill_in :email,  with: email
    fill_in :password,  with: password
    click_button 'Sign up'
 end

 def list_space(space_name: 'Reena\'s house',
    space_description: 'Lovely house with very nice garden',
    space_price: '100', availability_start: '2018-02-11', availability_end: '2018-02-15')
   # sign_up
   click_button 'List a Space'
   fill_in :space_name,  with: space_name
   fill_in :space_description,  with: space_description
   fill_in :space_price,  with: space_price
   fill_in :availability_start,  with: availability_start
   fill_in :availability_end,  with: availability_end
   click_button 'List my Space'
 end

end
