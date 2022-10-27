#管理者登録情報
Admin.create!(
   email: 'admin@admin',
   password: 'adminadmin',
)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {email: 'olivia@test.com', name: 'オリビア', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'james@test.com', name: 'James', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'sakura@test.com', name: '桜', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

Article.create!(
  [
    {title: 'タルトタタンの夢  著者：近藤史恵', content: 'フレンチレストランのシェフ三船がお客さんたちの不思議な事件や謎を解決していく日常系ミステリー小説です。たくさんのフランス料理が出てきてタルトタタンが無性に食べたくなります。', user_id: users[0].id },
    {title: '今日もごちそうさまでした', content: 'とにかく面白い。普段は面倒でやらない凝った料理も挑戦したくなるし、食への関心が高まる。最後にはレシピも載ってる。',  user_id: users[1].id },
    {title: '元気がない時にも読みたいビタミン小説！', content: '柚木麻子さんの『ランチのアッコちゃん』は美味しそうなランチ店がたくさん登場します。読むと元気も出てくるし、ランチ巡りがしたくなります！！',  user_id: users[2].id }
  ]
)