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

  def path_distance(path)
    distance = 0
    
    for 0..
      
  end
  
  def initialize
    @vertices = []
  end

  def paths(info)
    if info[:source].nil? or info[:destination].nil?
      raise "Require both a source vertex and destination vertex"
    elsif info[:max_weight].nil? and info[:max_edges] and info[:edges]
      raise "Need to search paths by max weight, max edges, or exact number of edges"
    end
    
  end
  
  def add_edge(edge)
    if edge[:source].nil? or edge[:destination].nil?
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
  
  def min_path(vertex1, vertex2)
    
  end
end