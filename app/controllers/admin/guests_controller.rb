class Admin::GuestsController < ApplicationController
#ゲストログイン機能
 def new_guest
   admin = Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
     admin.password = SecureRandom.urlsafe_base64
   end
   sign_in admin
   redirect_to admin_articles_path, alert: 'ゲストユーザーとしてログインしました。'
 end
end
