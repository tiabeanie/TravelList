class destination < ActiveRecord::Base
    belongs_to :user
    belongs_to :country
    has_many :destination_categories
    has_many :categories, through: :destination_categories
  
    def self.create_new_destination(details, category_name, category_ids, session_uid)
      @details = details
      @category_name = category_name
      @category_ids = category_ids
      @user = User.find(session_uid)
  
      set_country
  
      @destination = destination.new(
        :description => @details[:description],
        :country => @country,
      )
  
      set_categories
      @destination.user = @user
  
      @destination.save
      @destination
    end
  
    def self.update_destination(details, category_name, category_ids, destination)
      @details = details
      @category_name = category_name
      @category_ids = category_ids
      @destination = destination
  
      set_country
  
      @destination.update(
        :description => @details[:description],
        :country => @country
      )
  
      @destination.categories.clear
      set_categories
  
      @destination.save
      @destination
    end
  
    def self.set_country
      @country = Country.find_by(:name => @details[:country]).presence || Country.create(:name => @details[:country])
    end
  
    def self.set_categories
      unless @category_name.empty?
        # Checks for duplicates
        category = Category.find_by(:name => @category_name).presence || Category.create(:name => @category_name)
        @destination.categories << category
      end
      if @category_ids
        @category_ids.each do |id|
          @destination.categories << Category.find(id)
        end
      end
    end
  end