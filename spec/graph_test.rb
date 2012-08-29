require 'trains/graph.rb'

describe Graph do
  before do
    @graph = Graph.new
    @graph.add_edge(source: 1, destination: 2, weight: 1)
    @graph.add_edge(source: 2, destination: 3, weight: 2)
    @graph.add_edge(source: 1, destination: 4, weight: 3)
    @graph.add_edge(source: 4, destination: 2, weight: 1)
  end
   
  describe 'specific path' do
    it 'has a distance if valid' do
      @graph.path_distance(vertices: [1,2,3]).should == 3
      @graph.path_distance(vertices: [1,4,2]).should == 4
    end
    
    it 'does not have a distance if not valid' do
      @graph.path_distance(vertices: [1,3,2]).nil?.should == true
    end
  end
  
  it 'finds the number of available paths between two vertices with a maximum weight' do
    @graph.paths(source: 1, destination: 2, max_weight: 4).count.should == 2
    @graph.paths(source: 1, destination: 2, max_weight: 1).count.should == 1
  end
  
  it 'finds the number of available paths between two vertices with a maximum number of edges' do
    @graph.paths(source: 1, destination: 2, max_edges: 3).count.should == 2
    @graph.paths(source: 1, destination: 2, max_edges: 2).count.should == 1
  end
  
  it 'finds the number of available paths between two vertices with an exact number of edges' do
    @graph.paths(source: 1, destination: 2, edges: 1).count.should == 1
    @graph.paths(source: 1, destination: 2, edges: 2).count.should == 1
    @graph.paths(source: 1, destination: 2, edges: 3).count.should == 0
  end
  
  it 'finds the shortest path between two vertices by weight' do
    @graph.shortest_path(source: 1, destination: 2, weight: true).count.should == 1
  end
end
