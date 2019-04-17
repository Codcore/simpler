class TestsController < Simpler::Controller

  def index
    @time = Time.now
    headers['X'] = "Hello"
  end

  def create

  end

end
