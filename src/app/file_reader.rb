mode = "r+"

file = File.open("fruits.txt", mode)

puts file.read
apple
banana
orange
file.close