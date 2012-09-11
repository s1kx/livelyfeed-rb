module Livelyfeed
  module API

    # Returns extended information for the user
    #
    # @param id [Integer] A LivelyFeed User ID
    # @return [Hash]
    def user(id)
      get("/v1/users/#{id}")
    end

    # Returns extended information for the user
    #
    # @param username [String] A LivelyFeed username
    # @return [Hash]
    def user_by_username(username)
      get("/v1/users/find", username: username)
    end
    
    # Returns the groups the user participates in
    #
    # @return [Array<Hash>]
    def groups
      get("/v1/groups")
    end

    # Returns extended information for the group
    #
    # @param id [Integer] A LivelyFeed Group ID
    # @return [Hash]
    def group(id)
      get("/v1/groups/#{id}")
    end

    # Creates a group with the given attributes
    #
    # @param attributes [Hash] The groups attributes
    # @return [Hash]
    def create_group(attributes)
      post("/v1/groups", attributes)
    end

    # Updates the with the given attributes
    #
    # @param id [Integer] The groups ID
    # @param attributes [Hash] The groups attributes
    # @return [Hash]
    def update_group(id, attributes)
      put("/v1/groups/#{id}", attributes)
    end

    # Destroys a group
    #
    # @param id [Integer] The groups ID
    # @return [Hash]
    def destroy_group(id)
      delete("/v1/groups/#{id}")
    end

    # Follows a user
    #
    # @param user_id [Integer] A LivelyFeed User ID
    # @return [Hash]
    def follow(user_id)
      post("/v1/users/#{id}/follow")
    end

    # Unfollows a user
    #
    # @param user_id [Integer] A LivelyFeed User ID
    # @return [Hash]
    def unfollow(user_id)
      post("/v1/users/#{id}/unfollow")
    end

  end
end