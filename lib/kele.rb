require "httparty"
require "json"
require './lib/roadmap'

class Kele
  include HTTParty, Roadmap
  base_uri "https://www.bloc.io/api/v1/"
  
  def initialize(email, password)
      response = self.class.post("/sessions", body: { "email": email, "password": password } )
      puts response.code
      @auth_token = response["auth_token"]
      if @auth_token.nil? || response.nil?
          raise Error, "Unable to access user. Please try again with valid user information."
      end
  end
    
  def get_me
      response = self.class.get("/users/me", headers: {"authorization" => @auth_token })
      user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(id)
      response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token } )	
      @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page = nil) # optional method parameter
      if page != nil # return specified page
          response = self.class.get("/message_threads", headers: { "authorization": @auth_token }, body: { "page": page })
      else # return first page
          response = self.class.get("/message_threads", headers: { "authorization": @auth_token })
      end
      JSON.parse(response.body)
  end
    
  def create_message(sender, recipient_id, subject, stripped_text)
      response = self.class.post("https://www.bloc.io/api/v1/messages", headers: { "authorization": @auth_token },
      body: {
          "sender": sender,
          "recipient_id": recipient_id,
          "subject": subject,
          "stripped-text": stripped_text
        })
  end
  
  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
      response = self.class.post("/checkpoint_submissions", headers: { "authorization" => @auth_token },	
      body: {
          "checkpoint_id": checkpoint_id,
          "assignment_branch": assignment_branch,
          "assignment_commit_link": assignment_commit_link,
          "comment": comment,
          "enrollment_id": enrollment_id
      })
  end




end