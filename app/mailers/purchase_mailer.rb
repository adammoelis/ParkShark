class PurchaseMailer < ApplicationMailer

   def purchase_owner(owner, visitor, spot, listing)
     @owner = owner
     @visitor = visitor
     @spot = spot
     @listing = listing
     @url  = 'http://www.parkshark.herokuapp.com'
     mail(to: @owner.email, subject: "Congratulations, #{@owner.name}! Your spot was purchased!")
   end

   def purchase_visitor(visitor, owner, spot, listing)
     @owner = owner
     @visitor = visitor
     @spot = spot
     @listing = listing
     @url  = 'http://www.parkshark.herokuapp.com'
     mail(to: @visitor.email, subject: "Congratulations, #{@visitor.name}! You have purchased a spot!")
   end

end
