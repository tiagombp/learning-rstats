## Part 1 - Directed Networks

# Part 1 - Exercise 1 -----------------------------------------------------

# Directed igraph objects
# In this exercise you will learn how to create a directed graph from a dataframe, how to inspect whether a graph object is directed and/or weighted and how to extract those vertices at the beginning and end of directed edges.

library(igraph)

measles <- structure(list(from = c(45L, 45L, 172L, 180L, 45L, 180L, 42L, 
                                   45L, 182L, 45L, 182L, 45L, 12L, 181L, 45L, 181L, 181L, 175L, 
                                   181L, 181L, 181L, 45L, 45L, 22L, 22L, 45L, 10L, 180L, 31L, 45L, 
                                   45L, 45L, 45L, 181L, 182L, 34L, 182L, 17L, 45L, 93L, 180L, 178L, 
                                   42L, 45L, 184L, 45L, 45L, 10L, 17L, 8L, 31L, 17L, 17L, 17L, 17L, 
                                   45L, 56L, 45L, 58L, 58L, 186L, 11L, 19L, 45L, 64L, 64L, 11L, 
                                   179L, 54L, 180L, 10L, 12L, 180L, 45L, 74L, 5L, 180L, 181L, 179L, 
                                   78L, 39L, 45L, 82L, 82L, 44L, 1L, 47L, 47L, 12L, 93L, 93L, 93L, 
                                   45L, 183L, 10L, 97L, 45L, 64L, 11L, 47L, 7L, 21L, 37L, 58L, 74L, 
                                   42L, 19L, 106L, 12L, 18L, 34L, 21L, 31L, 78L, 16L, 45L, 116L, 
                                   116L, 116L, 7L, 11L, 188L, 7L, 7L, 7L, 37L, 106L, 7L, 7L, 56L, 
                                   56L, 14L, 18L, 78L, 79L, 17L, 16L, 34L, 4L, 6L, 145L, 145L, 145L, 
                                   45L, 172L, 18L, 14L, 39L, 148L, 153L, 153L, 45L, 153L, 73L, 45L, 
                                   156L, 156L, 37L, 68L, 148L, 123L, 123L, 102L, 102L, 153L, 110L, 
                                   98L, 153L, 153L, 169L, 174L, 173L, 146L, 184L, 184L, 177L, 177L, 
                                   184L, 184L, 184L, 82L, 45L, 82L, 175L), 
                          to = c(1L, 2L, 3L, 4L, 
                                 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 
                                 19L, 20L, 21L, 22L, 23L, 24L, 25L, 26L, 27L, 28L, 29L, 30L, 31L, 
                                 32L, 33L, 34L, 35L, 36L, 37L, 38L, 39L, 40L, 41L, 42L, 43L, 44L, 
                                 45L, 46L, 47L, 48L, 49L, 50L, 51L, 52L, 53L, 54L, 55L, 56L, 57L, 
                                 58L, 59L, 60L, 61L, 62L, 63L, 64L, 65L, 66L, 67L, 68L, 69L, 70L, 
                                 71L, 72L, 73L, 74L, 75L, 76L, 77L, 78L, 79L, 80L, 81L, 82L, 83L,
                                 84L, 85L, 86L, 87L, 88L, 89L, 90L, 91L, 92L, 93L, 94L, 95L, 96L,
                                 97L, 98L, 99L, 100L, 101L, 102L, 103L, 104L, 105L, 106L, 107L,
                                 108L, 109L, 110L, 111L, 112L, 113L, 114L, 115L, 116L, 117L, 118L,
                                 119L, 120L, 121L, 122L, 123L, 124L, 125L, 126L, 127L, 128L, 129L,
                                 130L, 131L, 132L, 133L, 134L, 135L, 136L, 137L, 138L, 139L, 140L, 
                                 142L, 143L, 144L, 145L, 146L, 147L, 148L, 149L, 150L, 151L, 152L, 
                                 153L, 154L, 155L, 156L, 157L, 158L, 159L, 160L, 161L, 162L, 163L, 
                                 164L, 165L, 166L, 167L, 168L, 169L, 170L, 171L, 172L, 175L, 176L, 
                                 177L, 178L, 179L, 180L, 181L, 182L, 183L, 185L, 186L, 187L, 188L
                                   )), 
                     .Names = c("from", "to"), class = "data.frame", row.names = c(NA,-184L))


# Get the graph object
g <- graph_from_data_frame(measles, directed = TRUE)

# is the graph directed?
is.directed(g)

# Is the graph weighted?
is.weighted(g)

# Subset each vertex from which each edge originates by using head_of(). This function takes two arguments, the first being the graph object and the second the edges to examine. For all edges you can use E(g).

# Where does each edge originate from?
table(head_of(g, E(g)))



# Part 1 - Exercise 2 -----------------------------------------------------

# Identifying edges for each vertex
# In this exercise you will learn how to identify particular edges. You will learn how to determine if an edge exists between two vertices as well as finding all vertices connected in either direction to a given vertex.

# First make a visualization of this network using plot(). You will improve this visualization later. It can be useful to visualize the network before analysis. To improve visibility of the plot of this network, you should make the vertex size equal to 0 and the edge arrow size equal to 0.1.
# 
# Check if there is an edge going in each direction between vertex 184 to vertex 178 using single brackets subsetting of the graph object. If a 1 is returned that indicates TRUE there is an edge. If a 0 is returned that indicates FALSE there is not an edge.
# 
# Using the function incident() identify those edges that go in either direction from vertex 184 or only those going out from vertex 184. The first argument should be the graph object, the second should be the vertex to examine and the third argument the mode indicating the direction. Choose from all, in and out.

# Make a basic plot
plot(g, 
     vertex.label.color = "black", 
     edge.color = 'gray77',
     vertex.size = 0,
     edge.arrow.size = 0.1,
     layout = layout_nicely(g))

# Is there an edge going from vertex 184 to vertex 178?
g['184', '178']

# Is there an edge going from vertex 178 to vertex 184?
g['178', '184']

# Show all edges going to or from vertex 184
incident(g, '184', mode = c("all"))

# Show all edges going out from vertex 184
incident(g, '184', mode = c("out"))


## Part 2 - Relationships between vertices


