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
    def user_followers(user_id)
      get("/v1/users/#{user_id}/followers")
    end

    # Returns users the given user id is following
    #
    # @param [Integer] user_id  A LivelyFeed User ID
    # @return [Hash] Response Object
    def user_followed_users(user_id)
      get("/v1/users/#{user_id}/followed_users")
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
    
    # Returns the groups the user participates in
    #
    # @return [Hash] Response Object
    def groups
      get("/v1/groups")
    end

    # Returns extended information for the group
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group(group_id)
      get("/v1/groups/#{group_id}")
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
    def group_members(group_id)
      get("/v1/groups/#{group_id}/members")
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

    # Returns the groups most recent 50 chat messages
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @return [Hash] Response Object
    def group_chat_messages(group_id)
      get("/v1/groups/#{group_id}/chat/messages")
    end

    # Returns the groups most recent 50 chat messages
    #
    # @param [Integer] group_id  A LivelyFeed Group ID
    # @param [Hash] attributes  The messages attributes
    # @return [Hash] Response Object
    def add_group_chat_message(group_id, attributes)
      post("/v1/groups/#{group_id}/chat/messages", attributes)
    end

    # Searches for people with the given query
    #
    # @param [String] query  Search query
    # @return [Hash] Response Object
    def search_people(query)
      get("/v1/search/people", query: query)
    end

  end
end