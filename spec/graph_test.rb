require 'trains/graph.rb'
require 'trains/queue.rb'

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
      @graph.path_weight([1,2,3]).should == 3
      @graph.path_weight([1,4,2]).should == 4
    end
    
    it 'does not have a distance if not valid' do
      @graph.path_weight([1,3,2]).nil?.should == true
    end
  end
  
  it 'finds the number of available paths between two vertices with a maximum weight' do
    @graph.num_paths(source: 1, destination: 2, max_weight: 4).should == 2
    @graph.num_paths(source: 1, destination: 2, max_weight: 1).should == 1
  end
    
  it 'finds the number of available paths between two vertices with a maximum number of edges' do
    @graph.num_paths(source: 1, destination: 2, max_edges: 2).should == 2
    @graph.num_paths(source: 1, destination: 2, max_edges: 1).should == 1
  end
  
  it 'finds the number of available paths between two vertices with an exact number of edges' do
    @graph.num_paths(source: 1, destination: 2, edges: 1).should == 1
    @graph.num_paths(source: 1, destination: 2, edges: 2).should == 1
    @graph.num_paths(source: 1, destination: 2, edges: 3).should == 0
  end
  
  it 'finds the shortest path between two vertices by weight' do
    @graph.shortest_path(source: 1, destination: 2, weight: true).should == 1
  end
end
