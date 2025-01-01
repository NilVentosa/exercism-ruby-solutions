class LocomotiveEngineer
  def self.generate_list_of_wagons(*arguments)
    arguments
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    one, two, three, *rest = each_wagons_id
    [three, *missing_wagons, *rest, one, two]
  end

  def self.add_missing_stops(route, **stops)
    { **route, stops: stops.values }
  end

  def self.extend_route_information(route, more_route_information)
    { **route, **more_route_information }
  end
end
