class Museum
  attr_reader :name,
              :exhibits,
              :patrons,
              :patrons_of_exhibits,
              :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @patrons_of_exhibits = {}
    @revenue = 0
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
    exhibits_by_cost.each do |exhibit|
      if patron.interests.include?(exhibit.name) && patron.spending_money >= exhibit.cost
        # @patrons_of_exhibits[exhibit] = [] if @patrons_of_exhibits[exhibit].nil?
        @patrons_of_exhibits[exhibit] ||= []
        @patrons_of_exhibits[exhibit] << patron
        patron.spend_money(exhibit.cost)
        @revenue += exhibit.cost
      end
    end
  end

  def exhibits_by_cost
    @exhibits.sort_by do |exhibit|
      -exhibit.cost
    end
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
      interested_patrons = @patrons.find_all do |patron|
        patron.interests.include?(exhibit.name)
      end
      patrons_by_exhibit[exhibit] = interested_patrons
      patrons_by_exhibit
    end
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].find_all do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    contestants = ticket_lottery_contestants(exhibit)
    return nil if contestants.empty?
    contestants.sample.name
  end

  def announce_lottery_winner(exhibit)
    winner = draw_lottery_winner(exhibit)
    return "No winners for this lottery" if winner.nil?
    "#{winner} has won the #{exhibit.name} edhibit lottery"
  end
end
