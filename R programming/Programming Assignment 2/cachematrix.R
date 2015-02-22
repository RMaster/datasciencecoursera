## 1.Initially cache value is null
## 2.Set Values of the matrix
## 3. get value of initialised stored matrix
## 4. Cache initialised matrix
## 5. get Initialise matrix from cache
## 6. Cache inverse of matrix
makeCacheMatrix <- function(x = numeric()) {
  
  
  ##1.Initially cache value is null
  cache <- NULL
  
  ##2.Set Values of the matrix
  setMatrix <- function(initValue) {
    x <<- initValue
    # since the matrix is assigned a initial value clear the cache.
    cache <<- NULL
  }
  
  ##3. get value of initialised stored matrix
    getMatrix <- function() {
      x
    }
  
  ##4. Cache initialised matrix
  cacheInitMatrix <- function(initMatrix) {
    cache <<- initMatrix
  }
  
  ##5. get Initialise matrix from cache
  getInitMatrix <- function() {
    cache
  }
  ##6. Cache inverse of matrix
  cacheInverseMatrix <- function(inverseMatrix) {
    cache <<- inverseMatrix
  }
  
  ##7. return a list. Each named element of the list is a function
  list(setMatrix = setMatrix, getMatrix = getMatrix, cacheInitMatrix = cacheInitMatrix, getInitMatrix = getInitMatrix)
    
}
  

### The following function calculates the inverse of a "special" matrix created with
# makeCacheMatrix

cacheSolve <- function(y, ...) {
  
  # get the cached value of initialised matrix
  CacheMatrix <- y$getInitMatrix()
  
  # if a cached value exists return it
  if(!is.null(CacheMatrix)) {
    message("getting cached data")
    return(CacheMatrix)
  }
  
  # otherwise get the matrix, caclulate the inverse and store it in
  # the cache
  data <- y$getMatrix()
  inverse <- solve(data)
  y$cacheInverseMatrix(inverse)
  
  # return the inverse
  inverse
  
}
