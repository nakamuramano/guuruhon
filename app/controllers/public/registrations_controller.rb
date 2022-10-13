# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController

#新規登録後の推移パス
def after_sign_up_path_for(resource)
 articles_path(resource)
end

end
