# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  
before_action :authenticate_user!, except: [:top, :new_guest]


#ログイン後の推移パス
def after_sign_in_path_for(resource)
  articles_path(resource)
end

end
