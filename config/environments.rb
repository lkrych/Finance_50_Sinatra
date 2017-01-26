configure :development, :test do
  set :database, 'sqlite3:development.db'
end
 
configure :production do
  # Database connection
  db = URI.parse(ENV['postgres://rjhwwgczdbzcyb:4b59a0be0868b55bd46c617c01ee9d538b969d6ce9a0b0f69621ed2888fe51d7@ec2-23-21-111-81.compute-1.amazonaws.com:5432/d8jti2jer9ngoq'] || 'postgres://localhost/mydb')
 
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
