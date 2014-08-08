############################################################
#
#  name:        Ryan Teskey
#  Assignment:  Assignment 8
#  Date:        3/3/2011
#  Class:       CIS 282
#  Description: makes a menu driven program from a hash and save it to a file
#               and read from the same file
############################################################
# Files
products = {}  #Hash.new
products_file = File.open('products.txt')
while ! products_file.eof?
  product = products_file.gets.chomp.split(',')
  products[ product[0] ] = [product[1],product[2]]
end
products_file.close
def menu
  puts '1. view all products', '2. add a new product ', '3. delete a product',
       '4. update a product', '5. highest priced product',
       '6. lowest priced product', '7. sum of all product prices', '8. exit'
end
def display(arr)
  arr.each do |id, array|
    puts "ID:#{id} | product name:#{array[0]} | product cost:$#{array[1]}"
    puts '---------------------------------------------------------------'
  end
end
def rand_id(arr)
  new_key = rand(900) + 100
  while arr.has_key?(new_key)
    new_key = rand(900) + 100
  end
  new_key
end
menu
menu_selection = ''
# exit out of the program
while menu_selection != '8' do
  menu_selection
  print 'put in the number from the list: '
  menu_selection = gets.chomp

  if( menu_selection == '1' )
    #View all products, IDs and Costs that looks nice
    display(products)
  elsif( menu_selection == '2' )
    # add a new product
    print 'Name: '
    name = gets.chomp
    print 'Cost: '
    cost = gets.to_f
    products[rand_id(products)] = [name, cost]
  elsif( menu_selection == '3' )
    #View all products, IDs and Costs that looks nice
    display(products)
    #delete a product
    print 'Enter ID to DELETE: '
    products.delete(gets.to_i)
  elsif( menu_selection == '4' )
    #update a product
    display(products)
    print 'What is the ID of the product to update:'
    get_id = gets.to_i
    print 'Name: '
    name = gets.chomp
    print 'Cost: '
    cost = gets.chomp
    products[get_id] = [name, cost]
  elsif( menu_selection == '5' )
    max_cost = 0
    product = ''
    products.each { |k,v|
      if v[1].to_f > max_cost
        max_cost =  v[1].to_f
        product =v[0]
      end
    }
    puts "#{product} is the highest priced product at $#{max_cost}"
  elsif( menu_selection == '6' )
    #lowest priced product
    lowest_price = products.first[1][1].to_f
    product_name = ''
    products.each do |id, array|
      if array[1].to_f < lowest_price
        lowest_price = array[1].to_f
        product_name = array[0]
      end
    end
    puts "#{product_name} is the lowest priced product at $#{lowest_price}"
  elsif( menu_selection == '7' )
    #sum of all product prices
    sum = 0
    products.each do |id, array|
      sum = array[1].to_f + sum
    end
    puts "#{sum} is the sum of all the products"
  end
  menu
end
# Writing to a file
products_file = File.open('products.txt', 'w')
  products.each do |id, array|
    products_file.puts "#{id},#{array[0]},#{array[1]}"
  end
products_file.close