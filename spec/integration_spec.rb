require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exception, false)

# describe('creates a City and Train path', {:type => :feature}) do
#   it('it creates a list of train routes and cities') do
#     visit('/trains/new')
#     fill_in('name', :with => 'Red Line')
#     click_button('Add Train')
#     expect(page).to have_content('Red Line')
#   end
# end
#
# describe('update Train path', {:type => :feature}) do
#   it('it updates a train record') do
#     visit('/t_update/:id')
#     fill_in('name', :with => 'Red Line')
#     click_button('Update Train')
#     expect(page).to have_content('Red Line')
#   end
# end
