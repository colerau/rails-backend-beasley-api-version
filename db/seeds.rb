# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# p1 = Product.create(category: "Body Butter", scent: "Lavender")
# p2 = Product.create(category: "Body Butter", scent: "Sweet Orange Mango")
# p3 = Product.create(category: "Body Butter", scent: "Grapefruit & Orange")
# p4 = Product.create(category: "Body Butter", scent: "Coconut & Vanilla")
# p5 = Product.create(category: "Body Butter", scent: "Oatmeal Cookie")
# p6 = Product.create(category: "Body Butter", scent: "Rose & Vanilla")

# Bubble Candle
Item.create(category: "Bubble Candle", scent: "Sweet Orange", color: "Tint of Orange")
Item.create(category: "Bubble Candle", scent: "Sweet Orange", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Peppermint & Lemon", color: "Pastel Green")
Item.create(category: "Bubble Candle", scent: "Peppermint & Lemon", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Lavender & Lemon", color: "Pastel Purple")
Item.create(category: "Bubble Candle", scent: "Lavender & Lemon", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Lavender", color: "Pastel Purple")
Item.create(category: "Bubble Candle", scent: "Lavender", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Coconut & Mango", color: "Tint of Orange")
Item.create(category: "Bubble Candle", scent: "Coconut & Mango", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Vanilla Rose", color: "Pastel Pink")
Item.create(category: "Bubble Candle", scent: "Peppermint Vanilla", color: "Pastel Green")
Item.create(category: "Bubble Candle", scent: "Peppermint Vanilla", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Warm Vanilla Kiss")
Item.create(category: "Bubble Candle", scent: "Apple Cider")
Item.create(category: "Bubble Candle", scent: "Apple Cinnamon Spice", color: "Pastel Tan")
Item.create(category: "Bubble Candle", scent: "Vanilla Latte", color: "Pastel Tan")
Item.create(category: "Bubble Candle", scent: "Vanilla Latte", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Brown Sugar Plum")
Item.create(category: "Bubble Candle", scent: "Cinnamon Pumpkin Pie")
Item.create(category: "Bubble Candle", scent: "Pumpkin & Vanilla")
Item.create(category: "Bubble Candle", scent: "Gingerbread", color: "Pastel Tan")
Item.create(category: "Bubble Candle", scent: "Gingerbread", color: "Plain")
Item.create(category: "Bubble Candle", scent: "Pumpkin Spice Latte", color: "Tint of Orange")
Item.create(category: "Bubble Candle", scent: "Pumpkin Spice Latte", color: "Plain")

# Body Butter
Item.create(category: "Body Butter", scent: "Lavender")
Item.create(category: "Body Butter", scent: "Sweet Orange Mango")
Item.create(category: "Body Butter", scent: "Grapefruit & Orange")
Item.create(category: "Body Butter", scent: "Coconut & Vanilla")
Item.create(category: "Body Butter", scent: "Oatmeal Cookie")
Item.create(category: "Body Butter", scent: "Rose & Vanilla")



# rails g migration add_name_of_column_to_table_name name_of_column:datatype --no-test-framework