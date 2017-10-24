category_list = [ "Breads", "Cakes", "Cookies", "Pies" ]

category_list.each do |name|
  p = Category.new
  p.name = name
  p.save
end
