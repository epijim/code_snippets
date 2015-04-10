library(riverplot)
data(minard)
nodes <- minard$nodes
edges <- minard$edges
colnames( nodes ) <- c( "ID", "x", "y" )
colnames( edges ) <- c( "N1", "N2", "Value", "direction" )
# Now we can add some style information to the “edge” columns, to mimick the orignal Minard plot:
  
# color the edges by troop movement direction
edges$col <- c( "#e5cbaa", "black" )[ factor( edges$direction ) ]
# color edges by their color rather than by gradient between the nodes
edges$edgecol <- "col"

# generate the riverplot object
river <- makeRiver( nodes, edges )
#The makeRiver function reads any columns that match the style information (like colors of the nodes) and uses it to create the river object. The river object is just a simple list, you can easily view and manipulate it — or create it with your own functions. The point about makeRiver is to make sure that the data is consistent.

#Once you have created a riverplot object with one of the above methods (or manually), you can plot it either with plot(x) or riverplot(x). I enforce the use of lines, and I also tell the plotting function to use a particular style. The default edges look curvy.

style <- list( edgestyle= "straight", nodestyle= "invisible" )
# plot the generated object
plot( river, lty= 1, default.style= style )
# Add cities
with( minard$cities, points( Longitude, Latitude, pch= 19 ) )
with( minard$cities, text( Longitude, Latitude, Name, adj= c( 0, 0 ) ) )
