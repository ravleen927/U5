require 'csv'

# Clear out existing data
Product.destroy_all
Category.destroy_all

# Path to  CSV file
csv_file_path = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file_path)

# Parse the CSV data, ensuring the column names are accessed as symbols
products_csv = CSV.parse(csv_data, headers: true, header_converters: :symbol)

products_csv.each do |row|
  # Find or create the category
  category = Category.find_or_create_by!(name: row[:category])

  # Create a product associated with the category
  category.products.create!(
    title: row[:name],
    price: row[:price],
    description: row[:description],
    stock_quantity: row[:stock_quantity]
  )
end

puts "Imported #{Category.count} categories and #{Product.count} products."