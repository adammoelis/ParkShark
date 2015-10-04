class PurchaseMailer < ApplicationMailer

   def purchase_owner(owner, visitor, spot)
     @owner = owner
     @visitor = visitor
     @spot = spot
     @url  = 'http://www.parkshark.herokuapp.com'
     mail(to: @owner.email, subject: "Congratulations, #{@owner.name}! Your spot was purchased!")
   end

end
