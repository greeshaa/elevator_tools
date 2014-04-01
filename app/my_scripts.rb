# -*- encoding : utf-8 -*-
my script

def addporches(build)
    porch_count = build.porch_count
    porch_count.times do | p |
      name = "#{p+1} подъезд"
      build_id = build.id
      porch = Porch.create(name: name,
                                      build_id: build_id)
      build.porches << porch
    end
  end




def lazy
  x = Build.count
  x.times do | b |
    house = Build.find_by_id(b+1)
    addporches(house)
  end
end

def lazy2
  x = Node.count
  x.times do | n |
    node = Node.find_by_id(n+1)
    adddest(node)
  end
end

def adddest(node)
  node.create_destination(name: "Работа")
end




Model.where('first_name like ? or last_name like ?', "%#{params[:first_name]}%", "%#{params[:last_name]}%")