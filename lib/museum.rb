class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    # recommendation = []
    # @exhibits.each do |exhibit|
    #   patron.interests.each do |interest|
    #     if exhibit.name == interest
    #       recommendation << exhibit
    #     end
    #   end
    # end
    # recommendation
    #
    # @exhibits.find_all do |exhibit|
    #   patron.interests.any? do |interest|
    #     exhibit.name == interest
    #   end
    # end

    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end
end
