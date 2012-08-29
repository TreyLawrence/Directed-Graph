require 'trains/queue.rb'

describe Queue do
  it "enqueues new elements" do
    queue = Queue.new
    queue.enqueue(1)
    queue.peek.should == 1
    queue.size.should == 1
    
    queue.enqueue(2)
    queue.peek.should == 1
    queue.size.should == 2
  end
  
  it "dequeues elements" do
    queue = Queue.new
    queue.enqueue(1)
    queue.enqueue(2)
    
    queue.dequeue.should == 1
    queue.size.should == 1
    
    queue.dequeue.should == 2
    queue.size.should == 0
    queue.empty?.should == true
  end
end
