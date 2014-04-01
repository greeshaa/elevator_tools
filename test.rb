
def search(address)
  if address[0] != nil
    street = Street.find(:all, :conditions => ['name LIKE ?', "%#{address[0]}%"])
     	if street.nil?
     		puts "message street not found"
     	else
     		build = Build.(:all, :conditions => ['name LIKE ?', "%#{address[1]}%"])
     		if build.nil?
     			puts "message build not found"
     		end
     	end
	end
end

search = "Партизанская, 8/1"
address = search.split(/[, \.?!]+/)