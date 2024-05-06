require 'uri'
require 'net/http'
require 'json'

class Logistics

  def initialize()
    @weight = 0.0
    @length = 0.0
    @width = 0.0
    @height = 0.0
    @point_of_departure = " "
    @destination = " "
    @distance = 0.0
    @price = 0.0
  end

  def input_consol
    #1. ввод с консоли параметров перевозимого груза
    puts("Введите вес(кг) груза:")
    @weight = gets.to_f #вес(кг)
    puts("Введите длину(см) груза:")
    @length = gets.to_f #длина(см)
    puts("Введите ширину(см) груза:")
    @width = gets.to_f #ширина(см)
    puts("Введите высоту(см) груза:")
    @height = gets.to_f #высота(см)

    #2.	Вводим в консоли название пункта отправления и название пункта назначения
    puts("Введите пункт отправления:")
    @point_of_departure = gets #пункт отправления
    puts("Введите пункт назначения:")
    @destination = gets #пункт назначения
  end

  def input_point_consol
    #2.	Вводим в консоли название пункта отправления и название пункта назначения
    puts("Введите пункт отправления:")
    @point_of_departure = gets #пункт отправления
    puts("Введите пункт назначения:")
    @destination = gets #пункт назначения
  end


  #3.	Через distancematrix.ai или любой другой сервис со схожим функционалом мы расчитываем расстояние, которое груз должен преодолеть
  def calculate_distance
    uri = URI('https://api.distancematrix.ai/maps/api/distancematrix/json')
    params = { :origins => @point_of_departure,
    :destinations => @destination,
    :key => 'WYbcjmKSMk5y3xuX6x0rzysmYCrJd21oJyazhZt4K6ioFpeGHBtc4qh1u0wsARP4'}
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    #puts res.body if res.is_a?(Net::HTTPSuccess)
    begin
      distance_s = JSON.parse(res.body)["rows"][0]["elements"][0]["distance"]["text"].split(" ")[0]#удаление "km"
      @distance=distance_s.to_f
    rescue
      puts "Данные пункты не найдены или построить маршрут мужду пунктами не возможно. Введите данные заново!"
      input_point_consol
      calculate_distance
    end
    return @distance
  end

  # 5. расчитываем стоимость перевозки (руб)
  def calculate_cost
    volume = (@length*@width*@height)/1000000.0
    if volume <= 1 # Если груз <= 1 м. куб., то цена = 1 руб за км,
      @price = 1*@distance
    elsif @weight < 10 # Если груз > 1 м. куб., но его вес < 10 кг, то цена = 2 руб за км
      @price = 2*@distance
    else # Если груз > 1 м. куб. и его вес >= 10кг, то цена = 3 рубля за км
      @price = 3*@distance
    end
    return  {weight: @weight, length: @length, width: @width, height: @height, distance: @distance, price: @price}
  end


   #ввод для тестов
   def data_input_test_calculate_cost(weight_test,length_test,width_test,height_test,distance_test)
    #1.Вводим параметры перевозимого груза - вес(кг), длина(см), ширина(см), высота(см)
    @weight=weight_test #вес груза
    @length= length_test #длина груза в см
    @width=width_test #ширина груза в см
    @height=height_test #высота груза в см
    @distance = distance_test
  end

  def data_input_test_calculate_distance(point_of_departure, destination)
    # 2.Вводим название пункта отправления и название пункта назначения
    @point_of_departure = point_of_departure
    #puts "Пункт отправления #{@point_of_departure}"
    @destination = destination
  end
end
