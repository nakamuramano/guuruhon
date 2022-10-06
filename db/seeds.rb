Admin.create!(
   email: 'admin@admin',
   password: 'adminadmin',
)

Tag.create([
  { tag_name: '和食' },
  { tag_name: 'アジア料理' },
  { tag_name: 'ヨーロッパ料理' },
  { tag_name: '肉料理' },
  { tag_name: '魚料理' },
  { tag_name: '鍋料理' },
  { tag_name: 'スイーツ' },
  { tag_name: 'その他' },
  { tag_name: '中華' },
  { tag_name: 'イタリアン' },
  { tag_name: 'フレンチ' },
  { tag_name: '洋食・西洋料理' },
  { tag_name: '韓国料理' },
  { tag_name: '居酒屋・バー' },
  { tag_name: '食堂' },
])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
