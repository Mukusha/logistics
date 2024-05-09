require 'uri'
require 'net/http'
require 'json'

class LogisticController < ApplicationController

  def index
    @users = User.all
    @cargos = Cargo.all
  end

 def show
    @cargo = Cargo.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @cargo = Cargo.new(calculate(@user[:id],cargo_params[:weight],cargo_params[:length],cargo_params[:width],cargo_params[:height],cargo_params[:point_of_departure],cargo_params[:destination]))
      if  @cargo.save
         redirect_to :logistic_index
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cargo = Cargo.find(params[:id])
    @user = User.find(@cargo.user_id)
    @cargo.destroy
    @user.destroy
    redirect_to :logistic_index
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name,:father_name, :phone,:email)
  end

  private
  def cargo_params
    params.require(:cargo).permit(:weight, :length,:width, :height,:point_of_departure, :destination)
  end



  def calculate(id_user, weight, length,width, height,point_of_departure, destination)
    # расчитываем расстояние, которое груз должен преодолеть
    uri = URI('https://api.distancematrix.ai/maps/api/distancematrix/json')
    params = { :origins => point_of_departure,
    :destinations => destination,
    :key => 'WYbcjmKSMk5y3xuX6x0rzysmYCrJd21oJyazhZt4K6ioFpeGHBtc4qh1u0wsARP4'}
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)

    begin
      distance = JSON.parse(res.body)["rows"][0]["elements"][0]["distance"]["text"].split(" ")[0].to_f#удаление "km"
    rescue
      redirect_to :logistic_index
    end

   # 5. расчитываем стоимость перевозки (руб)
    if length.to_f*width.to_f*height.to_f <= 1000000.0 # Если груз <= 1 м. куб., то цена = 1 руб за км,
      price = 1*distance.to_f
    elsif weight.to_f < 10 # Если груз > 1 м. куб., но его вес < 10 кг, то цена = 2 руб за км
      price = 2*distance.to_f
    else # Если груз > 1 м. куб. и его вес >= 10кг, то цена = 3 рубля за км
      price = 3*distance.to_f
    end
    return  {user_id: id_user,weight: weight.to_f, length: length.to_f, width: width.to_f, height: height.to_f,point_of_departure: point_of_departure, destination: destination, distance: distance.to_f, price: price.to_f}
  end

end
