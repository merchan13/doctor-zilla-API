module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def stub_user_signed_in?(user)
    allow_any_instance_of(ApplicationController).to receive(:user_signed_in?).and_return(true)
  end

  def stub_access_token #stub_require_login!
    allow_any_instance_of(ApplicationController).to receive(:require_login!).and_return(true)
  end

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

end
