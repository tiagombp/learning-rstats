
# Part 1 - Exercise 1 -----------------------------------------------------

# Load igraph
library(igraph)

# o friends object:
friends <- 
  structure(list(name1 = c("Jessie", "Jessie", "Sidney", "Sidney", 
                         "Karl", "Sidney", "Britt", "Shayne", "Sidney", "Sidney", "Jessie", 
                         "Donnie", "Sidney", "Rene", "Shayne", "Jessie", "Rene", "Elisha", 
                         "Eugene", "Berry", "Odell", "Odell", "Britt", "Elisha", "Lacy", 
                         "Britt", "Karl"), 
                 name2 = c("Sidney", "Britt", "Britt", "Donnie", 
                         "Berry", "Rene", "Rene", "Sidney", "Elisha", "Whitney", "Whitney", 
                         "Odell", "Odell", "Whitney", "Donnie", "Lacy", "Lacy", "Eugene", 
                         "Jude", "Odell", "Rickie", "Karl", "Lacy", "Jude", "Whitney", 
                         "Whitney", "Tommy")), 
            .Names = c("name1", "name2"), 
            class = "data.frame", 
            row.names = c(NA,-27L))

# Inspect the first few rows of the dataframe 'friends'
head(friends)

# Convert friends dataframe to a matrix
friends.mat <- as.matrix(friends)

# Convert friends matrix to an igraph object
g <- graph.edgelist(friends.mat, directed = FALSE)



# Part 1 - Exercise 2 -----------------------------------------------------

# Counting vertices and edges
# A lot of basic information about a network can be extracted from an igraph object. In this exercise you will learn how to count the vertices and edges from a network by applying several functions to the graph object g.
# Each row of the friends dataframe represents an edge in the network.

# Subset vertices and edges
V(g)
E(g)

# Count number of edges
gsize(g)


# Part 1 - Exercise 3 -----------------------------------------------------

# Node attributes and subsetting
# In this exercise you will learn how to add attributes to vertices in the network and view them.

genders <- c("M", "F", "F", "M", "M", "M", "F", "M", "M", "F", "M", "F", 
  "M", "F", "M", "M")

ages <- c(18, 19, 21, 20, 22, 18, 23, 21, 22, 20, 20, 22, 21, 18, 19, 
          20)

# Inspect the objects 'genders' and 'ages'
genders
ages

# Create new vertex attribute called 'gender'
g <- set_vertex_attr(g, "gender", value = genders)

# Create new vertex attribute called 'age'
g <- set_vertex_attr(g, "age", value = ages)

# View all vertex attributes in a list
vertex_attr(g)

# View attributes of first five vertices in a dataframe
V(g)[[1:5]] 


# Part 1 - Exercise 4 -----------------------------------------------------

# Edge attributes and subsetting
# In this exercise you will learn how to add attributes to edges in the network and view them. For instance, we will add the attribute 'hours' that represents how many hours per week each pair of friends spend with each other.

hours <- c(1, 2, 2, 1, 2, 5, 5, 1, 1, 3, 2, 1, 1, 5, 1, 2, 4, 1, 3, 1, 
           1, 1, 4, 1, 3, 3, 4)

# View hours
hours

# Create new edge attribute called 'hours'
g <- set_edge_attr(g, "hours", value = hours)

# View edge attributes of graph object
edge_attr(g)

# Find all edges that include "Britt"
E(g)[[inc('Britt')]]  

# Find all pairs that spend 4 or more hours together per week
E(g)[[hours>=4]]  



# Part 1 - Exercise 5 -----------------------------------------------------

# Visualizing attributes
# In this exercise we will learn how to create igraph objects with attributes directly from dataframes and how to visualize attributes in plots. We will use a second network of friendship connections between students.

friends1_edges <- structure(list(
  name1 = c("Joe", "Joe", "Joe", "Erin", "Kelley", 
            "Ronald", "Ronald", "Ronald", "Michael", "Michael", "Michael", 
            "Valentine", "Troy", "Troy", "Jasmine", "Jasmine", "Juan", "Carey", 
            "Frankie", "Frankie", "Micheal", "Micheal", "Keith", "Keith", "Gregory"), 
  name2 = c("Ronald", "Michael", "Troy", "Kelley", 
            "Valentine", "Troy", "Perry", "Jasmine", "Troy", "Jasmine",
            "Juan", "Perry", "Jasmine", "Juan", "Juan", "Carey", "Demetrius", "Frankie", 
            "Micheal", "Merle", "Merle", "Alex", "Gregory", "Marion", "Marion"), 
  hours = c(1L, 3L, 2L, 3L, 5L, 1L, 3L, 5L, 2L, 1L, 3L, 5L, 
            3L, 2L, 6L, 1L, 2L, 2L, 1L, 1L, 2L, 1L, 1L, 3L, 2L)), 
  .Names = c("name1", "name2", "hours"), 
  class = "data.frame", row.names = c(NA, -25L))

friends1_nodes <- structure(
  list(name = c("Joe", "Erin", "Kelley", "Ronald", "Michael", 
                "Valentine", "Troy", "Jasmine", "Juan", "Carey", "Frankie", "Micheal", 
                "Keith", "Gregory", "Perry", "Demetrius", "Merle", "Alex", "Marion"), 
       gender = c("M", "F", "F", "M", "M", "F", "M", "F", "M", "F", "F", "M", "M", "M", "M", "M", "M", "F", "F")), 
  .Names = c("name", "gender"), 
  class = "data.frame", 
  row.names = c(NA, -19L))

# Create an igraph object with attributes directly from dataframes
g1 <- graph_from_data_frame(d = friends1_edges, vertices = friends1_nodes, directed = FALSE)


# Subset edges greater than or equal to 5 hours
E(g1)[[hours>=5]]  

# Set vertex color by gender
V(g1)$color <- ifelse(V(g1)$gender == "F", "orange", "dodgerblue")

# Plot the graph
plot(g1, vertex.label.color = "black")



# Part 1 - Exercise 6 -----------------------------------------------------

# igraph network layouts
# The igraph package provides several built in layout algorithms for network visualization. Depending upon the size of a given network different layouts may be more effective in communicating the structure of the network. Ideally the best layout is the one that minimizes the number of edges that cross each other in the network. In this exercise you will explore just a few of the many default layout algorithms. Re-executing the code for each plot will lead to a slightly different version of the same layout type. Doing this a few times can help to find the best looking visualization for your network.

# Plot the graph object g1 in a circle layout
plot(g1, vertex.label.color = "black", layout = layout_in_circle(g1))

# Plot the graph object g1 in a Fruchterman-Reingold layout 
plot(g1, vertex.label.color = "black", layout = layout_with_fr(g1))

# Plot the graph object g1 in a Tree layout 
m <- layout_as_tree(g1)
plot(g1, vertex.label.color = "black", layout = m)

# Plot the graph object g1 using igraph's chosen layout 
m1 <- layout_nicely(g1)
plot(g1, vertex.label.color = "black", layout = m1)



# Part 1 - Exercise 7 -----------------------------------------------------

# Visualizing edges
# In this exercise you will learn how to change the size of edges in a network based on their weight, as well as how to remove edges from a network which can sometimes be helpful in more effectively visualizing large and highly clustered networks. In this introductory chapter, we have just scratched the surface of what's possible in visualizing igraph networks. You will continue to develop these skills in future chapters.

# Create a vector of weights based on the number of hours each pair spend together
w1 <- E(g1)$hours

# Plot the network varying edges by weights
m1 <- layout_nicely(g1)
plot(g1, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = w1,
     layout = m1)


# Create a new igraph object by deleting edges that are less than 2 hours long 
g2 <- delete_edges(g1, E(g1)[hours < 2])


# Plot the new graph 
w2 <- E(g2)$hours
m2 <- layout_nicely(g2)

plot(g2, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = w2,
     layout = m2)



# Part 1 - dúvidas --------------------------------------------------------



E(g1)[[inc('Jasmine')]]
E(g1)[inc('Jasmine')]
