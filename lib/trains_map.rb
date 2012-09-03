class TrainsMap
  def initialize(string_of_stations_and_distances)
    @trainsMap = Graph.new
    stations_and_distances = string_of_stations_and_distances.split(', ')
    stations_and_distances.each { |edge| @trainsMap.add_edge(source: edge[0], destination: edge[1], weight: edge[2].to_i)}
  end
  
  def distance(path)
    stops = path.split('-')
    @trainsMap.path_weight(stops) || "NO SUCH ROUTE"
  end
  
  def num_trips(path, limit_by)
    source, destination = path.split('-')
    
    if limit_by[:max_stops]
      hash = {source: source, destination: destination, max_edges: limit_by[:max_stops]}
    elsif limit_by[:num_stops]
      hash = {source: source, destination: destination, edges: limit_by[:num_stops]}
    elsif limit_by[:max_distance]
      hash = {source: source, destination: destination, max_weight: limit_by[:max_distance]}
    end
    
    @trainsMap.num_paths(hash)
  end
  
  def shortest_route(path)
    source, destination = path.split('-')
    @trainsMap.shortest_path(source: source, destination: destination, weight: true)
  end
end