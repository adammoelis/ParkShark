module MilesHelper

  def miles_options
    (1..100).map{|mile| ["#{mile} mile radius", mile]}
  end

end
