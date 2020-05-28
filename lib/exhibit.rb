class Exhibit
  attr_reader :name,
              :cost

  def initialize(exhibit_params)
    @name = exhibit_params[:name]
    @cost = exhibit_params[:cost]
  end
end
