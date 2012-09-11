module Livelyfeed
  module API

    # Returns extended information for the user
    #
    # @param id [Integer] A LivelyFeed User ID
    # @return [Hash]
    def user(id)
      get("/v1/users/show", id: id)[:body]
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
      get("/v1/groups", id: id)[:body]
    end

    # Creates a group with the given attributes
    #
    # @param attributes [Hash] The groups attributes
    # @return [Hash]
    def create_group(attributes)
      post("/v1/groups/create", attributes)[:body]
    end

    # Updates the with the given attributes
    #
    # @param id [Integer] The groups ID
    # @param attributes [Hash] The groups attributes
    # @return [Hash]
    def update_group(id, attributes)
      post("/v1/groups/update", attributes.merge(id: id))[:body]
    end

    # Destroys a group
    #
    # @param id [Integer] The groups ID
    # @return [Hash]
    def destroy_group(id)
      post("/v1/groups/destroy", id: id)[:body]
    end

  end
end