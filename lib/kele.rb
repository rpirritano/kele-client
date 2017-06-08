require 'httparty'

class Kele
    include HTTParty
    base_uri 'https://www.bloc.io/api/v1'
    
    def initialize(email, password)
        response = self.class.post('/sessions', body: { "email": email, "password": password })

        if @auth == nil
            'Invalid Credentials'
        else
            'Welcome'
        end
        
        @auth = response['auth_token']
    end
end
