require 'securerandom'

4.times do |num|
  nm = format 'user%02d', num
  user = User.find_by(name: nm)
  user = User.create! name: nm, data: { data: SecureRandom.uuid } if !user

  4.times do |rnum|
    nm = format 'resource%02d', rnum
    resource = Resource.find_by(user:, name: nm)

    Resource.create! user:, name: nm, data: { data: SecureRandom.uuid } if !resource
  end
end
