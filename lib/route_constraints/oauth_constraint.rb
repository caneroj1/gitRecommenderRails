class OAuthConstraint
  def initialize
    @state = ENV["state"]
  end

  def matches?(request)
    @state.eql?(request.params[:state])
  end
end
