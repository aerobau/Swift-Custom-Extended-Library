Swift-Custom-Extended-Library
=============================

A custom library containing more data structures for Apple Swift

Stuctures:

Array2D<T> 
- Allows the storage of items of any type in a 2D array
- Custom subscripts
  - [x, y] item at x,y
  - [x: x] (explicit declatration of variable name) Array of items at index x
  - [y: y] (explicit declatration of variable name) Array of items at index y
- Appending is done with arrays instead of items because of the two dimmensions, and there are methods to append
  in both the x and y direction
- Same goes for removal and insertion, they can be done n the x, y, or z direction

Array3D<T> 
- Allows the storage of items of any type in a 3D array
- Custom subscripts
  - [x, y, z] item at coordinate x,y,z
  - [x: x] (explicit declatration of variable name) Array2D of items at index x
  - [y: y] (explicit declatration of variable name) Array2D of items at index y
  - [z: z] (explicit declatration of variable name) Array2D of items at index z
  - [x: x, y: y] (explicit declaration of variable names) Array of items at coordinate x, y
  - [x: x, z: z] (explicit declaration of variable names) Array of items at coordinate x, z
  - [y: y, z: z] (explicit declaration of variable names) Array of items at coordinate y, z
- Appending is done with arrays instead of items because of the two dimmensions, and there are methods to append
  in both the x, y, and z direction
- Same goes for removal and insertion, they can be done in the x, y or z direction

Stack<T>
- Standard stack
- top() and pop() both return the item at the top of the stack, pop() removes the item at the same time
- push(item: T) appends an item at the end of the stack
- Stack can be initialized with an array, with the end of the array becoming the top of the stack
- isEmpty() returns whether the Stack is empty

Deque<T>
- Double ended queue allows for faster insertion and removal at the beginning and end of the queue under most
  circumstances
- back() and popBack() both return the item at the back of the queue, popBack() removes the item at the same time
- front() and popFront() both return the item at the front of the queue, popFront removes the item at the same time
- pushFront(item: T) adds an item to the front of the queue
- pushBack(item: T) adds an item to the back of the queue
- shrinkToSize(size: Int) alternatively removes items from the front and back until the count of items is equal to the
  input size and returns a deque<T> of the removed items
- clear() clears the Deque and returns a Deque<T> clone of the cleared Deque
- toArray() creates and returns an Array<T> of the items in the Deque<T>
- indexRangeToArray(start: Int end: Int) creates and returns an Array of the items in the Deque<T> in the index range
- removeIndexRange(start: Int, end: Int) removes the items in the index range and returns a Deque<T> of the items removed







