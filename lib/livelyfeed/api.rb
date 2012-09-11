module Livelyfeed
  module API

    # Returns extended information for the user
    #
    # @param id [Integer] A LivelyFeed User ID
    # @return [Hash]
    def user(id)
      get("/v1/users/#{id}")[:body]
    end
    
    # Returns the groups the user participates in
    #
    # @return [Array<Hash>]
    def groups
      get("/v1/groups")[:body]
    end

    # Returns extended information for the group
    #
    # @param id [Integer] A LivelyFeed Group ID
    # @return [Hash]
    def group(id)
      get("/v1/groups/#{id}")[:body]
    end

    # Creates a group with the given attributes
    #
    # @param attributes [Hash] The groups attributes
    # @return [Hash]
    def create_group(attributes)
      post("/v1/groups", attributes)[:body]
    end

  end
end