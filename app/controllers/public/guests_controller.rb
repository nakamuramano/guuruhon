class Public::GuestsController < ApplicationController
before_action :authenticate_user!, except: [:top, :new_guest]

 def new_guest
   user = User.find_or_create_by!(email: 'guest@example.com') do |user|
     user.password = SecureRandom.urlsafe_base64
     user.name = 'ゲストユーザー'
   end
   sign_in user
   redirect_to articles_path, alert: 'ゲストユーザーとしてログインしました。'
 end


end
