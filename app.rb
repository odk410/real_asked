require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model.rb' # DB관련 파일 (model)

set :bind, '0.0.0.0'

enable :sessions # Session이라는 Hash를 사용할 수 있게 한다.

get '/' do

  @questions = Question.all

  erb :index
end

get '/ask' do
  Question.create(
    :name => params["name"],
    :content => params["question"]
  )

  # erb :ask
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )

  redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
end

# 로그인?
# 1. 로그인 하려고 하는 사람이 우리 회원인지 검사한다.
#  - User 데이터베이스에 있는 사람인지 확인
#  - 로그인하려고 하는 사람이 제출한 email이 User DB에 있는지 확인한다.
# 2. 만약에 있으면,
#  - 비밀번호를 체크한다 == (제출된 비번 == DB의 비번)
#     3. 만약에 맞으면 로그인 성공~!
#     4. 비번이 틀리면 다시 비번을 치라고 한다.
# 3. 만약 없으면,
#  - 회원이 아니기 때문에 -> 회원가입 페이지로 보낸다.
get '/login' do

  erb :login
end

get '/login_session' do

    @message = ""

    if User.first(:email => params["email"])  #로그인에서 입력한 아이디와 DB에 등록된 아이디가 같은지 확인한다.
      if User.first(:email => params["email"]).password == params["password"]
        session[:email] = params["email"] #Session은 해시처럼 동작한다.
        @message = "로그인이 되었습니다."
      else
        @message = "비번이 틀렸어요"
      end
    else
      @message = "해당하는 이메일의 유저가 없습니다."
    end

    params["email"]
    params["password"]

 erb :login_session
end

get '/logout' do
  session.clear
  redirect to '/'
end
