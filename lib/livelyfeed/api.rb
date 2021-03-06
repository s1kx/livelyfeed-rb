module Livelyfeed
  module API
    
    # Returns extended information for the user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user(user_id)
      get("/v1/users/#{user_id}")
    end

    # Returns extended information for the user
    #
    # @param [String] username  A LivelyFeed username
    # @return [Hash] Response Object
    def user_by_username(username)
      get("/v1/users/find", username: username)
    end

    # Returns extended information for the currently signed in user
    #
    # @return [Hash] Response Object
    def current_user
      get("/v1/users/me")
    end

    # Creates a user with the given attributes
    #
    # @param [Hash] attributes  The users attributes
    # @return [Hash] Response Object
    def create_user(attributes)
      post("/v1/users", attributes)
    end

    # Updates a user with the given attributes
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @param [Hash] attributes  The users attributes
    # @return [Hash] Response Object
    def update_user(user_id, attributes)
      put("/v1/users/#{user_id}", attributes)
    end

    # Destroys a user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def destroy_user(user_id)
      delete("/v1/users/#{user_id}")
    end

    # Returns followers for the given user id
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_followers(user_id, params = {})
      get("/v1/users/#{user_id}/followers", params)
    end

    # Returns users the given user id is following
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_followed_users(user_id, params = {})
      get("/v1/users/#{user_id}/followed_users", params)
    end

    # Checks whether a user is following another
    #
    # @param [Integer] source User ID that follows
    # @param [Integer] target User ID that gets followed
    # @return [Hash] Response Object
    def following?(source, target)
      get("/v1/users/#{source}/is_following/#{target}")
    end

    # Follows a user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def follow(user_id)
      post("/v1/users/#{user_id}/follow")
    end

    # Unfollows a user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def unfollow(user_id)
      post("/v1/users/#{user_id}/unfollow")
    end
    
    # Returns the groups a user participates in
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_groups(user_id, params = {})
      get("/v1/users/#{user_id}/groups", params)
    end

    # Returns extended information for the group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group(group_id)
      get("/v1/groups/#{group_id}")
    end

    # Returns extended information for the group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group_by_slug(group_slug)
      get("/v1/groups/find", slug: group_slug)
    end

    # Creates a group with the given attributes
    #
    # @param [Hash] attributes  The groups attributes
    # @return [Hash] Response Object
    def create_group(attributes)
      post("/v1/groups", attributes)
    end

    # Updates the group with the given attributes
    #
    # @param [Integer] group_id  The groups ID
    # @param [Hash] attributes  The groups attributes
    # @return [Hash] Response Object
    def update_group(group_id, attributes)
      put("/v1/groups/#{group_id}", attributes)
    end

    # Destroys a group
    #
    # @param [Integer] group_id  The groups ID
    # @return [Hash] Response Object
    def destroy_group(group_id)
      delete("/v1/groups/#{group_id}")
    end

    # Leave a group
    #
    # @param [Integer] group_id  The groups ID
    # @return [Hash] Response Object
    def leave_group(group_id)
      post("/v1/groups/#{group_id}/leave")
    end

    # Returns the groups members
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group_members(group_id, params = {})
      get("/v1/groups/#{group_id}/members", params)
    end

    # Add a user to a group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def add_group_member(group_id, user_id)
      post("/v1/groups/#{group_id}/members", id: user_id)
    end

    # Removes a user from a group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def remove_group_member(group_id, user_id)
      delete("/v1/groups/#{group_id}/members/#{user_id}")
    end

    # Returns the users group invitations
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @param [String] filter  Type of invitations to show (nil, "unanswered", "answered", "accepted", "denied")
    # @return [Hash] Response Object
    def user_group_invitations(user_id, filter = "unanswered")
      get("/v1/users/#{user_id}/group_invitations", filter: filter)
    end

    # Returns the specified group invitation for that user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @param [Integer] invitation_id  A LivelyFeed Group Invitation ID
    # @return [Hash] Response Object
    def user_group_invitation(user_id, invitation_id)
      get("/v1/users/#{user_id}/group_invitations/#{invitation_id}")
    end

    # Accepts the specified group invitation for that user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @param [Integer] invitation_id  A LivelyFeed Group Invitation ID
    # @return [Hash] Response Object
    def accept_user_group_invitation(user_id, invitation_id)
      post("/v1/users/#{user_id}/group_invitations/#{invitation_id}/accept")
    end

    # Denies the specified group invitation for that user
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @param [Integer] invitation_id  A LivelyFeed Group Invitation ID
    # @return [Hash] Response Object
    def deny_user_group_invitation(user_id, invitation_id)
      post("/v1/users/#{user_id}/group_invitations/#{invitation_id}/deny")
    end

    # Returns the groups invitations
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [String] filter  Type of invitations to show (nil, "unanswered", "answered", "accepted", "denied")
    # @return [Hash] Response Object
    def group_invitations(group_id, filter = "unanswered")
      get("/v1/groups/#{group_id}/invitations", filter: filter)
    end

    # Invite a LivelyFeed user to a group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def invite_group_livelyfeed_user(group_id, user_id)
      post("/v1/groups/#{group_id}/invitations", type: 'user', user_id: user_id)
    end

    # Invite a Facebook user to a group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [String] facebook_id  A Facebook User ID
    # @return [Hash] Response Object
    def invite_group_facebook_user(group_id, facebook_id)
      post("/v1/groups/#{group_id}/invitations", type: 'facebook', facebook_id: facebook_id)
    end

    # Returns the groups 50 most recent chat messages
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group_chat_messages(group_id, params = {})
      get("/v1/groups/#{group_id}/chat/messages", params)
    end

    # Receive a specific message from a group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] message_id  A LivelyFeed Message ID
    # @return [Hash] Response Object
    def group_chat_message(group_id, message_id)
      get("/v1/groups/#{group_id}/chat/messages/#{message_id}")
    end

    # Send a message to the group chat
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Hash] attributes  The messages attributes
    # @return [Hash] Response Object
    def add_group_chat_message(group_id, attributes)
      post("/v1/groups/#{group_id}/chat/messages", attributes)
    end

    # Like a message in the group chat
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] message_id  A LivelyFeed Message ID
    # @return [Hash] Response Object
    def like_group_chat_message(group_id, message_id)
      post("/v1/groups/#{group_id}/chat/messages/#{message_id}/likes")
    end

    # Unlike a message in the group chat
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] message_id  A LivelyFeed Message ID
    # @return [Hash] Response Object
    def unlike_group_chat_message(group_id, message_id)
      delete("/v1/groups/#{group_id}/chat/messages/#{message_id}/likes")
    end

    # Returns the groups moments
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group_moments(group_id, params = {})
      get("/v1/groups/#{group_id}/feed/moments", params)
    end

    # Returns the specified moment in the given group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def group_moment(group_id, moment_id)
      get("/v1/groups/#{group_id}/feed/moments/#{moment_id}")
    end

    # Returns the users moments
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_moments(user_id, params = {})
      get("/v1/users/#{user_id}/moments", params)
    end

    # Creates a moment
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] message_id  A LivelyFeed Message ID
    # @return [Hash] Response Object
    def create_moment(group_id, message_id)
      post("/v1/groups/#{group_id}/feed/moments", message_id: message_id)
    end

    # Destroys a moment
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def destroy_moment(group_id, moment_id)
      delete("/v1/groups/#{group_id}/feed/moments/#{moment_id}")
    end

    # Get a moments likes
    #
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def moment_likes(moment_id)
      get("/v1/moments/#{moment_id}/likes")
    end

    # Like a moment
    #
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def like_moment(moment_id)
      post("/v1/moments/#{moment_id}/likes")
    end

    # Unlike a moment
    #
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def unlike_moment(moment_id)
      delete("/v1/moments/#{moment_id}/likes")
    end

    # Gets a moments comments
    #
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @return [Hash] Response Object
    def moment_comments(moment_id)
      get("/v1/moments/#{moment_id}/comments")
    end

    # Creates a moment comment
    #
    # @param [Integer] moment_id  A LivelyFeed Moment ID
    # @param [String] text  The comments content
    # @return [Hash] Response Object
    def create_moment_comment(moment_id, text)
      post("/v1/moments/#{moment_id}/comments", text: text)
    end

    # Returns the users live feed items
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_live_feed(user_id, params = {})
      get("/v1/users/#{user_id}/live", params)
    end

    # Searches for people with the given query
    #
    # @param [String] query  Search query
    # @return [Hash] Response Object
    def search_people(query)
      get("/v1/search/people", query: query)
    end

    # Show the status of a password reset
    #
    # @param [String] token  A password reset token
    # @return [Hash] Response Object
    def password_reset(token)
      get("/v1/password_resets/#{token}")
    end

    # Request a password reset for a given email
    #
    # @param [String] email  A LivelyFeed User's Email Address
    # @return [Hash] Response Object
    def request_password_reset(email)
      post("/v1/password_resets", email: email)
    end

    # Use a password reset with a given token and new password
    #
    # @param [String] token  A password reset token (received in email after request_password_reset)
    # @param [String] new_password  The users new password
    # @return [Hash] Response Object
    def use_password_reset(token, new_password)
      put("/v1/password_resets/#{token}", password: new_password)
    end

    # Creates an attachment
    #
    # @param [String] file  An image or video to be uploaded
    # @return [Hash] Response Object
    def create_attachment(file)
      params = { file: file }
      post("/v1/attachments", params, plain_params: true) do |request|
        request.options[:timeout] = 60
      end
    end

  end
end