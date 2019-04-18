class TestsController < Simpler::Controller

  def index
    @time = Time.now
    headers['X'] = "Hello"
  end

  def create
  end

  def show
    render plain: params.to_s
  end

end
