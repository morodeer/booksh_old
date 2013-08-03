include ApplicationHelper
def sign_in(user)
  visit signin_path
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def obtain(book)
	visit book_path(book)
	click_link 'Make specimen'
end