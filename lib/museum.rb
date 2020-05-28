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

  def admit(patron)
    @patrons << patron
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

  def patrons_by_exhibit_interest
    # patrons_by_exhibit = {}
    # @exhibits.each do |exhibit|
    #   interested_patrons = @patrons.find_all do |patron|
    #     patron.interests.include?(exhibit.name)
    #   end
    #   patrons_by_exhibit[exhibit] = interested_patrons
    # end
    # patrons_by_exhibit

    @exhibits.reduce({}) do |patrons_by_exhibit, exhibit|
      binding.pry
      interested_patrons = @patrons.find_all do |patron|
        patron.interests.include?(exhibit.name)
      end
      patrons_by_exhibit[exhibit] = interested_patrons
      patrons_by_exhibit
    end
  end
end
