module Payment
  def self.create_customer(user, stripe_token)
    customer = Stripe::Customer.create(
        email: user.email,
        source: stripe_token
    )
    user.update(stripe_id: customer.id)
    return customer
  end

  def self.set_customer(user, stripe_token)
    customer = Stripe::Customer.new user.stripe_id
    customer.source = stripe_token
    customer.save
  end

  def self.create_transaction(customer, amount)
    Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        description: 'Testing Stripe',
        currency: 'usd'
    )
  end

  def self.find_card(customer)
    Stripe::Customer.retrieve_source(customer.id, customer.default_source)
  end
end