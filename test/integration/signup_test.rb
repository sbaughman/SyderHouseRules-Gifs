require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest

  test 'user should be able to sign up' do
    assert_difference 'User.count' do
      visit('/')
      click_link('Sign Up')
      fill_in('Username', with: "EmilioEstevez")
      fill_in('Email', with: "example@example.com")
      fill_in('Bio', with: "I like turtles")
      fill_in('Password', match: :first, with: "password")
      fill_in('Password confirmation', with: "password")
      click_on('Create User')
    end
  end

end
