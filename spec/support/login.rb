def login
  user = create(:user, email: 'alan@email.com', password: 'epanenem')
  sign_in user
  user
end
