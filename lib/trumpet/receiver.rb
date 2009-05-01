module Trumpet
  class Receiver
    include TrumpetResource
    
    @@attributes = [
      :id         , :url,
      :source_url , :creator_id       ,
      :author     , :author_name      ,
      :avatar_url , :authored_at      ,
      :title      , :description      ,
      :tags       , :location_string  ,
      :lat        , :lng              ,
      :radius     , :channels         ,
      :keywords   , :name             ,  
      :created_at , :updated_at       ,
      :errors
    ]
    attr_reader *@@attributes
    
    
    def self.create(options={})
      Receiver.new(Trumpet::Request.post("/receivers", :parameters => options))
    end
    
    def self.find(id)
      Receiver.new(Trumpet::Request.get("/receivers/#{id}"))
    end

    def delete
      !!Trumpet::Request.delete("/receivers/#{@id}")
    end
    
    def messages
      messages = Trumpet::Request.get("/receivers/#{@id}/messages")
      messages.map { |attributes| Message.new(attributes) }
    end
    
    def listen
      #TODO: impliment this
    end
    
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end