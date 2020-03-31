class Destination < ActiveRecord::Base
    belongs_to :user
    belongs_to :country
  
    def self.create_new_destination(details, session_uid)
      @details = details
      @user = User.find(session_uid)
  
      set_country
  
      @destination = destination.new(
        :description => @details[:description],
        :country => @country,
      )
  
      @destination.save
      @destination
    end
  
    def self.update_destination(details, destination)
      @details = details
      @destination = destination
  
      set_country
  
      @destination.update(
        :description => @details[:description],
        :country => @country
      )
  
      @destination.save
      @destination
    end
  
    def self.set_country
      @country = Country.find_by(:name => @details[:country]).presence || Country.create(:name => @details[:country])
    end
  end