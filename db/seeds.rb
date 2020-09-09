brand = Brand.create(name: "Nike")
sneaker = Sneaker.create(size: "10",gender: "Man", style: "white" ,price: 100, quantity: 1, bar_code: "11111", brand: brand)
user = User.create(name: "Come For Kick", username: "yhelflaco24", email: "yarhumher@hotmail.com", password: "cuyamel")

p sneaker
# t.string "size"
# t.string "gender"
# t.string "style"
# t.integer "price"
# t.integer "quantity"
# t.string "color"
# t.string "bar_code"
# t.string "brand_id"