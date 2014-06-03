module AuthenticationHelpers
  module Controller
    def sign_in(user)
      controller.stub(:current_user).and_return(user)
      controller.stub(:user_id).and_return(user.id)
    end
  end

  module Feature
    def sign_in(user, options={})
      visit "/login"
      fill_in I18n.t('login.login-box.username'), with: user.first.username
      fill_in I18n.t('login.login-box.password'), with: options[:password]
      click_button I18n.t('login.login-box.submit')
    end
  end
end
