module Roadmap
    
    def get_roadmap(roadmap_id)
        response = Kele.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token } )
        JSON.parse(response.body)
        @roadmap = response["name"]
        puts "Your roadmaps is #{@roadmap}."
        puts response
        return @roadmap
    end
    
    def get_checkpoint(checkpoint_id)
        response = Kele.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token } )
        JSON.parse(response.body)
    end
end