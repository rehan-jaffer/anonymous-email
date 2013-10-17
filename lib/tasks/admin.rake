task :make_admin => :environment do |t,args|

  User.find_by_id(args[:user]).make_admin!

end
