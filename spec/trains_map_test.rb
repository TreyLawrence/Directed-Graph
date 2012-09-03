require 'trains_map.rb'
require 'trains_map/graph.rb'
require 'trains_map/queue.rb'

describe TrainsMap do
  before {@trains = TrainsMap.new("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7")}
  
  it 'gives the distance of a route' do
    @trains.distance('A-B-C').should == 9
    @trains.distance('A-D').should == 5
    @trains.distance('A-D-C').should == 13
    @trains.distance('A-E-B-C-D').should == 22
    @trains.distance('A-E-D').should == "NO SUCH ROUTE"
  end
  
  describe 'trip count between two stops' do
    it 'is known when given a maximum number of stops' do
      @trains.num_trips('C-C', max_stops: 3).should == 2
    end
    
    it 'is known when given an exact number of stops' do
      @trains.num_trips('A-C', num_stops: 4).should == 3
    end
    
    it 'is known when given a maximum distance' do
      @trains.num_trips('C-C', max_distance: 30).should == 7
    end
  end
  
  it 'finds the length of the shortest route between two stops' do
    @trains.shortest_route('A-C')
    @trains.shortest_route('B-B')
  end
end
