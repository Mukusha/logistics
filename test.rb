require_relative 'logistics.rb'

#Пример - Ввод данных через консоль
puts "Ввод данных через консоль"
c = Logistics.new()
c.input_consol()
puts "Расстояние: "+c.calculate_distance.to_s
puts "Стоимость перевозки: "+c.calculate_cost[:price].to_s

#Тесты функции calculate_distance
puts "Тесты функции calculate_distance"
#Тест №1
print "   Тест №1"
test_1 = Logistics.new()
test_1.data_input_test_calculate_distance("45.041251, 39.031935","45.0398887, 38.9734448")
t1 = test_1.calculate_distance
if t1 == 7.9
  print ": ✔️\n"
else
  print "❗ Результат: #{t1}  Правильный ответ: 7.9\n"
end

#Тест №2
print "   Тест №2"
test_2 = Logistics.new()
test_2.data_input_test_calculate_distance("51.4822656,-0.1933769","51.4994794,-0.1269979")
t2 = test_2.calculate_distance
if t2 == 7.6
  print ": ✔️\n"
else
  print "❗ Результат: #{t2}  Правильный ответ: 7.6\n"
end

#Тест №3
print "   Тест №3"
test_3 = Logistics.new()
test_3.data_input_test_calculate_distance("1677, Easton Rd, Willow Grove, PA 19090, USA","119 S Easton Rd, Glenside, PA 19038, USA")
t3 = test_3.calculate_distance
if t3 == 4.8
  print ": ✔️\n"
else
  print "❗ Результат: #{t3}  Правильный ответ: 4.8\n"
end

#Тесты функции calculate_cost
puts "Тесты функции calculate_cost"
#Тест №4
print "   Тест №4"
test_4 = Logistics.new()
test_4.data_input_test_calculate_cost(100.0, 100.0, 100.0, 99.99, 500.1)
t4 = test_4.calculate_cost[:price]
if t4 == 500.1
  print ": ✔️\n"
else
  print "❗ Результат: #{t4}  Правильный ответ: 0\n"
end

#Тест №5
print "   Тест №5"
test_5 = Logistics.new()
test_5.data_input_test_calculate_cost(5, 100.1, 100.1, 100.99, 500.1)
t5 = test_5.calculate_cost[:price]
if t5 == 1000.2
  print ": ✔️\n"
else
  print "❗ Результат: #{t5}  Правильный ответ: 0\n"
end

#Тест №6
print "   Тест №6"
test_6 = Logistics.new()
test_6.data_input_test_calculate_cost(15, 100.1, 100.1, 100.99, 500)
t6 = test_6.calculate_cost[:price]
if t6 == 1500
  print ": ✔️\n"
else
  print "❗ Результат: #{t6}  Правильный ответ: 0\n"
end

#Тест №7
print "   Тест №7"
test_7 = Logistics.new()
test_7.data_input_test_calculate_cost(15, 100.0, 100.0, 100, 500)
t7 = test_7.calculate_cost[:price]
if t7 == 500
  print ": ✔️\n"
else
  print "❗ Результат: #{t7}  Правильный ответ: 0\n"
end
