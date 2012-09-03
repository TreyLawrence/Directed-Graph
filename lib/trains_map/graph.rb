class Graph
  class Vertex
    def initialize
      @edges = []
    end
    
    def object=(object)
      @object = object
    end

    def object
      @object
    end

    def edges
      @edges
    end

    def add_edge(edge)
      @edges << edge
    end
  end

  class Edge
    def initialize(destination, weight)
      @weight = weight
      @destination = destination
    end
    
    def destination
      @destination
    end

    def weight
      @weight
    end
  end
  
  def initialize
    @vertices = []
  end
  
  def add_edge(edge)
    if edge[:source].nil? || edge[:destination].nil?
      raise "Require both a source vertex and destination vertex"
    end
    
    source_vertex = @vertices.select{|vertex| vertex.object == edge[:source]}.first
    destination_vertex = @vertices.select{|vertex| vertex.object == edge[:destination]}.first
    
    if source_vertex.nil?
      source_vertex = Vertex.new
      source_vertex.object = edge[:source]
      @vertices << source_vertex
    end
    
    if destination_vertex.nil?
      destination_vertex = Vertex.new
      destination_vertex.object = edge[:destination]
      @vertices << destination_vertex
    end
    
    source_vertex.add_edge(Edge.new(destination_vertex, edge[:weight]))
  end

  def path_weight(path)
    weight = 0
    vertex = @vertices.select{ |vortex| vortex.object == path.first }.first
    
    if vertex
      for i in 1..path.length-1
        edge_to_next_vertex = vertex.edges.select { |edge| edge.destination.object == path[i] }.first
        if edge_to_next_vertex.nil?
          return nil
        end
        vertex = edge_to_next_vertex.destination
        weight += edge_to_next_vertex.weight
      end
      weight
    end
  end

  def num_paths(info)
    if info[:source].nil? || info[:destination].nil?
      raise "Require both a source vertex and destination vertex"
    elsif info[:max_weight].nil? && info[:max_edges].nil? && info[:edges].nil?
      raise "Need to search paths by max weight, max edges, or exact number of edges"
    end
    
    source_vertex = @vertices.select{ |vertex| vertex.object == info[:source] }.first
    destination_vertex = @vertices.select { |vertex| vertex.object == info[:destination] }.first
    
    if (info[:max_edges] && info[:max_edges] < 1) ||
       (info[:max_weight] && info[:max_weight] < 1)
      0
    elsif info[:max_edges]
      bfs_max_edges(source_vertex, destination_vertex, info[:max_edges])
    elsif info[:max_weight]
      bfs_max_weight(source_vertex, destination_vertex, info[:max_weight])
    elsif info[:edges]
      bfs_edges(source_vertex, destination_vertex, info[:edges])
    end
  end
  
  def shortest_path(info)
    if info[:source].nil? || info[:destination].nil?
      raise "Require both a source vertex and destination vertex"
    elsif info[:weight].nil? && info[:edges].nil?
      raise "Need to search paths by weight or number of edges"
    end
    
    source_vertex = @vertices.select{ |vertex| vertex.object == info[:source] }.first
    destination_vertex = @vertices.select { |vertex| vertex.object == info[:destination] }.first

    if info[:weight]
      bfs_smallest_weight(source_vertex, destination_vertex)
    elsif info[:edges]
      #TODO
      raise "Not implemented yet"
    end
  end
  
  private
    def bfs_smallest_weight(source, destination)
      queue = Queue.new
      shortest = 1/0.0
      source.edges.each {|edge| queue.enqueue({vertex: edge.destination, weight_so_far: edge.weight}) }
      
      while !queue.empty?
        next_one = queue.dequeue
        vertex = next_one[:vertex]
        weight_so_far = next_one[:weight_so_far]
        
        if weight_so_far < shortest
          vertex.edges.each {|edge| queue.enqueue({vertex: edge.destination, weight_so_far: weight_so_far + edge.weight}) }
        end
        
        if vertex == destination
          shortest = weight_so_far
        end
      end
      shortest
    end
    
    def bfs_max_edges(source, destination, max_edges)
      matches = 0
      queue = Queue.new
      source.edges.each {|edge| queue.enqueue({vertex: edge.destination, edge_num: max_edges - 1}) }
      
      while !queue.empty?
        next_one = queue.dequeue
        vertex = next_one[:vertex]
        edge_num = next_one[:edge_num]
        
        if edge_num > 0
          vertex.edges.each {|edge| queue.enqueue({vertex: edge.destination, edge_num: edge_num - 1}) }
        end
        
        if vertex == destination
          matches += 1
        end
      end
      matches
    end
  
    def bfs_max_weight(source, destination, max_weight)
      matches = 0
      queue = Queue.new
      source.edges.each {|edge| queue.enqueue({vertex: edge.destination, weight_left: max_weight - edge.weight}) }
      
      while !queue.empty?
        next_one = queue.dequeue
        vertex = next_one[:vertex]
        weight_left = next_one[:weight_left]
        
        vertex.edges.each do |edge|
          if weight_left - edge.weight > 0
            queue.enqueue({vertex: edge.destination, weight_left: weight_left - edge.weight})
          end
        end
        
        if vertex == destination
          matches += 1
        end
      end
      matches
    end
    
    def bfs_edges(source, destination, edges)
      matches = 0
      queue = Queue.new
      source.edges.each {|edge| queue.enqueue({vertex: edge.destination, edge_num: edges - 1}) }
      
      while !queue.empty?
        next_one = queue.dequeue
        vertex = next_one[:vertex]
        edge_num = next_one[:edge_num]
        
        if edge_num > 0
          vertex.edges.each {|edge| queue.enqueue({vertex: edge.destination, edge_num: edge_num - 1}) }
        elsif vertex == destination
          matches += 1
        end
      end
      matches
    end
end