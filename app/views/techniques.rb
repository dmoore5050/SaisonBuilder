
module Techniques

  def Techniques.render_list
    techniques_list = <<EOS

    SECONDARY FERMENTATION - extended fermentation of a beer that
occurs after primary fermentation is either complete or nearly
complete. The beer is transferred from the primary fermenter to
a new fermentation vessel that has been sanitized and preferaly
purged of oxygen. Secondary fermentation is often associated with
aging of the beer on specialized ingredients, such as fruit, add'l
hops (see DRYHOPPING), coffee, cocoa, spices, wood, or botanicals.
    Secondary fermentation is sometimes used for the addition of
a supplementary yeast, most often one differing from the one used
for primary fermentation. In these cases, the beer is transferred
to secondary and both a new yeast (in many cases, this new yeast
will be Brettanomyces), and a source of fermentable for the new
yeast to consume (fruit, sugar, etc.).

    DRYHOPPING - extended aging of a post-primary-fermentation
beer on whole or pelletized hops. Generally, this occurs in either
a secondary fermentation vessel or in a keg. Hops are either placed
in a sanitized fine strainer bag and weighted with sanitized weights
(if pellets) or added directly to the secondary fermentation vessel
(if whole). Because hops are naturally anti-microbial, there is no
need to sanitize the hops themselves before adding them.
EOS

    puts techniques_list
  end

end