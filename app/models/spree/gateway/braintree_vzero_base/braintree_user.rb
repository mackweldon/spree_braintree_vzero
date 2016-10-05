module Spree
  class Gateway
    class BraintreeVzeroBase
      class BraintreeUser
        attr_reader :user, :spree_user, :request, :utils

        delegate :shipping_address, :billing_address, to: :spree_user

        def initialize(provider, spree_user, order)
          @utils = Utils.new(provider, order)
          @spree_user = spree_user
          @request = provider::Customer
          # this produces an extra get request to fetch this user from the BT API
          # but appears not to be used
          # if spree_user.braintree_id
          #           @user = @request.find(spree_user.braintree_id)
          #         end
          
        end

        def register_user
          @request.create(@utils.customer_data(spree_user))
        end
      end
    end
  end
end
