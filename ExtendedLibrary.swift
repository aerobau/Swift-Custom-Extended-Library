//
//  Array2D.swift
//  Library
//
//  Created by Alexander Robau on 6/24/14.
//
//

import Foundation

struct Array2D<T> {
  var container: Array<Array<T>>
  var xCount: Int
  var yCount: Int
  
  init(container:Array<Array<T>>) {
    self.container = container
    xCount = container.count
    if xCount > 0 {
      yCount = container[0].count
    } else {
      yCount = 0
    }
  }
  
  init(xCount: Int, yCount: Int, repeatedElement: T) {
    container = []
    var yArray = Array(count: yCount, repeatedValue: repeatedElement)
    for var i = 0; i < xCount; i++ {
      container.append(yArray)
    }
    self.xCount = xCount
    self.yCount = yCount
  }
  
  init(xCount: Int, repeatedArray: Array<T>) {
    container = []
    for var i = 0; i < xCount; i++ {
      container.append(repeatedArray)
    }
    self.xCount = xCount
    self.yCount = repeatedArray.count
  }
  
  init(yCount: Int, repeatedArray: Array<T>) {
    container = []
    for var i = 0; i < repeatedArray.count; i++ {
      container.append([])
      for var j = 0; j < yCount; j++ {
        container[i].append(repeatedArray[i])
      }
    }
    xCount = container.count
    self.yCount = yCount
  }
  
  mutating func appendXArray(array: Array<T>) {
    assert(array.count == yCount || xCount == 0,
      "Array being appended is not the correct size")
    container.append(array)
    xCount++
  }
  
  mutating func appendYArray(array: Array<T>) {
    assert(array.count == xCount || yCount == 0,
      "Array being appended is not the correct size")
    for var i = 0; i < xCount; i++ {
      container[i].append(array[i])
    }
    yCount++
  }
  
  mutating func insertXArray(array: Array<T>, atIndex: Int) {
    assert(array.count == yCount,
      "Array being inserted is not the correct size")
    assert(atIndex < xCount && atIndex >= 0, "Index is out of range")
    container.insert(array, atIndex: atIndex)
    xCount++
  }
  
  mutating func insertYArray(array: Array<T>, atIndex: Int) {
    assert(array.count == xCount,
      "Array being inserted is not the correct size")
    assert(atIndex < yCount && atIndex >= 0, "Index is out of range")
    for var i = 0; i < xCount; i++ {
      container[i].insert(array[i], atIndex: atIndex)
    }
    yCount++
  }
  
  mutating func removeXArrayAtIndex(index: Int) -> Array<T> {
    assert(index < xCount && index >= 0, "Index is out of range")
    xCount--
    return container.removeAtIndex(index)
  }
  
  mutating func removeYArrayAtIndex(index: Int) -> Array<T> {
    assert(index < yCount && index >= 0, "Index is out of range")
    var removed: Array<T> = []
    for var i = 0; i < yCount; i++ {
      removed.append(container[i].removeAtIndex(index))
    }
    yCount--
    return removed
  }
  
  mutating func removeLastXArray() -> Array<T> {
    xCount--
    return container.removeLast()
  }
  
  mutating func removeLastYArray() -> Array<T> {
    var removed: Array<T> = []
    for var i = 0; i < xCount; i++ {
      removed.append(container[i].removeLast())
    }
    yCount--
    return removed
  }
  
  mutating func reverseX() {
    container.reverse()
  }
  
  mutating func reverseY() {
    for var i = 0; i < xCount; i++ {
      container[i].reverse()
    }
  }
  
  mutating func swapDimensions() {
    var newContainer: Array<Array<T>> = []
    for var i = 0; i < yCount; i++ {
      newContainer.append([])
      for var j = 0; j < xCount; j++ {
        newContainer[i].append(container[j][i])
      }
    }
    swap(&xCount, &yCount)
    container = newContainer
  }
  
  func copy() -> Array2D<T> {
    return Array2D(container: container.copy())
  }
  
  func subscriptIsValid(#x: Int, y: Int) -> Bool {
    return !(x < 0 || x > xCount || y < 0 || y > yCount)
  }
  
  subscript(x: Int, y: Int) -> T {
    get {
      assert(subscriptIsValid(x: x, y: y), "Subscript is out of range")
      return container[x][y]
    }
    
    set {
      assert(subscriptIsValid(x: x, y: y), "Subscript is out of range")
      container[x][y] = newValue
    }
  }
  
  subscript(#x: Int) -> Array<T> {
    get {
      assert(x < xCount && x >= 0, "Subscript is out of range")
      return container[x]
    }
    
    set {
      assert(x < xCount && x >= 0, "Subscript is out of range")
      assert(newValue.count == yCount, "Array is not the correct size")
      container[x] = newValue
    }
  }
  
  subscript(#y: Int) -> Array<T> {
    get {
      assert(y < yCount && y >= 0, "Subscript is out of range")
      var referencedArray: Array<T> = []
      for var i = 0; i < xCount; i++ {
        referencedArray.append(container[i][y])
      }
      return referencedArray
    }
    
    set {
      assert(y < yCount && y >= 0, "Subscript is out of range")
      assert(newValue.count == xCount, "Array is not the correct size")
      for var i = 0; i < xCount; i++ {
        container[i][y] = newValue[i]
      }
    }
  }
}

struct Array3D<T> {
  var container: Array<Array<Array<T>>>
  var xCount: Int
  var yCount: Int
  var zCount: Int
  
  init(container:Array<Array<Array<T>>>) {
    self.container = container
    xCount = container.count
    if xCount > 0 {
      yCount = container[0].count
      if yCount > 0 {
        zCount = container[0][0].count
      } else {
        zCount = 0
      }
    } else {
      yCount = 0
      zCount = 0
    }
  }
  
  init(xCount: Int, yCount: Int, zCount: Int, repeatedElement: T) {
    container = []
    for var i = 0; i < xCount; i++ {
      container.append([])
      for var j = 0; j < yCount; j++ {
        container[i].append([])
        for var k = 0; k < zCount; k++ {
          container[i][j].append(repeatedElement)
        }
      }
    }
    self.xCount = xCount
    self.yCount = yCount
    self.zCount = zCount
  }
  
  init(xCount: Int, repeatedArray2D: Array2D<T>) {
    container = []
    var repeatedArray2DCopy = Array2D(container: repeatedArray2D.container)
    repeatedArray2DCopy.swapDimensions()
    for var i = 0; i < xCount; i++ {
      container.append(repeatedArray2DCopy.container)
    }
    self.xCount = xCount
    yCount = repeatedArray2D.yCount
    zCount = repeatedArray2D.xCount
  }
  
  init(yCount: Int, repeatedArray2D: Array2D<T>) {
    container = []
    for var i = 0; i < repeatedArray2D.xCount; i++ {
      container.append([])
      for var j = 0; j < yCount; j++ {
        container[i].append(repeatedArray2D[x: i])
      }
    }
    xCount = container.count
    self.yCount = yCount
    zCount = repeatedArray2D.yCount
  }
  
  init(zCount: Int, repeatedArray2D: Array2D<T>) {
    container = []
    for var i = 0; i < repeatedArray2D.xCount; i++ {
      for var j = 0; j < repeatedArray2D.yCount; j++ {
        for var k = 0; k < zCount; k++ {
          container[i][j].append(repeatedArray2D[i,j])
        }
      }
    }
    xCount = repeatedArray2D.xCount
    yCount = repeatedArray2D.yCount
    self.zCount = zCount
  }
  
  mutating func appendXArray2D(array2D: Array2D<T>) {
    assert(array2D.yCount == yCount && array2D.xCount == zCount ||
      xCount == 0, "Array2D being appended is not the correct size")
    var array2DCopy = Array2D(container: array2D.container)
    array2DCopy.swapDimensions()
    container.append(array2DCopy.container)
    xCount++
  }
  
  mutating func appendYArray2D(array2D: Array2D<T>) {
    assert(array2D.xCount == xCount && array2D.yCount == zCount ||
      yCount == 0, "Array2D being appended is not the correct size")
    for var i = 0; i < xCount; i++ {
      container[i].append(array2D[x: i])
    }
    yCount++
  }
  
  mutating func appendZArray2D(array2D: Array2D<T>) {
    assert(array2D.xCount == xCount && array2D.yCount == yCount ||
      zCount == 0, "Array2D being appended is not the correct size")
    for var i = 0; i < xCount; i++ {
      for var j = 0; j < yCount; j++ {
        container[i][j].append(array2D[i,j])
      }
    }
    zCount++
  }
  
  mutating func insertXArray2D(array2D: Array2D<T>, atIndex: Int) {
    assert(array2D.yCount == yCount && array2D.xCount == zCount,
      "Array being inserted is not the correct size")
    assert(atIndex < xCount && atIndex >= 0, "Index is out of range")
    var array2DCopy = Array2D(container: array2D.container)
    array2DCopy.swapDimensions()
    container.insert(array2DCopy.container, atIndex: atIndex)
    xCount++
  }
  
  mutating func insertYArray2D(array2D: Array2D<T>, atIndex: Int) {
    assert(array2D.xCount == xCount && array2D.yCount == zCount,
      "Array being inserted is not the correct size")
    assert(atIndex < yCount && atIndex >= 0, "Index is out of range")
    for var i = 0; i < xCount; i++ {
      container[i].insert(array2D[x: i], atIndex: atIndex)
    }
    yCount++
  }
  
  mutating func insertZArray2D(array2D: Array2D<T>, atIndex: Int) {
    assert(array2D.xCount == xCount && array2D.yCount == yCount,
      "Array being inserted is not the correct size")
    assert(atIndex < zCount && atIndex >= 0, "Index is out of range")
    for var i = 0; i < xCount; i++ {
      for var j = 0; j < yCount; j++ {
        container[i][j].insert(array2D[i,j], atIndex: atIndex)
      }
    }
    zCount++
  }
  
  mutating func removeXArray2DAtIndex(index: Int) -> Array2D<T> {
    assert(index < xCount && index >= 0, "Index is out of range")
    xCount--
    var removed = Array2D(container: container.removeAtIndex(index))
    removed.swapDimensions()
    return removed
  }
  
  mutating func removeYArray2DAtIndex(index: Int) -> Array2D<T> {
    assert(index < yCount && index > 0, "Index is out of range")
    var removed: Array<Array<T>> = []
    var removedArray2D = Array2D<T>(container: removed)
    for var i = 0; i < xCount; i++ {
      removedArray2D.appendXArray(container[i].removeAtIndex(index))
    }
    yCount--
    return removedArray2D
  }
  
  mutating func removeZArray2DAtIndex(index: Int) -> Array2D<T> {
    assert(index < zCount && index > 0, "Index is out of range")
    var removed: Array<Array<T>> = []
    var removedArray2D = Array2D<T>(container: removed)
    for var i = 0; i < xCount; i++ {
      var removedXArray: Array<T> = []
      for var j = 0; j < yCount; j++ {
        removedXArray.append(container[i][j].removeAtIndex(index))
      }
      removedArray2D.appendXArray(removedXArray)
    }
    zCount--
    return removedArray2D
  }
  
  mutating func removeLastXArray2D() -> Array2D<T> {
    xCount--
    return Array2D<T>(container: container.removeLast())
  }
  
  mutating func removeLastYArray2D() -> Array2D<T> {
    var removed: Array<Array<T>> = []
    var removedArray2D = Array2D<T>(container: removed)
    for var i = 0; i < xCount; i++ {
      removedArray2D.appendXArray(container[i].removeLast())
    }
    yCount--
    return removedArray2D
  }
  
  mutating func removeLastZArray2D() -> Array2D<T> {
    var removed: Array<Array<T>> = []
    var removedArray2D = Array2D<T>(container: removed)
    for var i = 0; i < xCount; i++ {
      var removedXArray: Array<T> = []
      for var j = 0; j < yCount; j++ {
        removedXArray.append(container[i][j].removeLast())
      }
      removedArray2D.appendXArray(removedXArray)
    }
    zCount--
    return removedArray2D
  }
  
  mutating func reverseX() {
    container.reverse()
  }
  
  mutating func reverseY() {
    for var i = 0; i < xCount; i++ {
      container[i].reverse()
    }
  }
  
  mutating func reverseZ() {
    for var i = 0; i < xCount; i++ {
      for var j = 0; j < yCount; j++ {
        container[i][j].reverse()
      }
    }
  }
  
  func copy() -> Array3D<T> {
    return Array3D(container: container.copy())
  }
  
  func subscriptIsValid(#x: Int, y: Int, z: Int) -> Bool {
    return x >= 0 && x < xCount && y >= 0 && y < yCount && z >= 0 && z < zCount
  }
  
  subscript(x: Int, y: Int, z: Int) -> T {
    get {
      assert(subscriptIsValid(x: x, y: y, z: z), "Subscript is out of range")
      return container[x][y][z]
    }
    
    set {
      assert(subscriptIsValid(x: x, y: y, z: z), "Subscript is out of range")
      container[x][y][z] = newValue
    }
  }
  
  subscript(#x: Int) -> Array2D<T> {
    get {
      assert(x >= 0 && x < xCount, "Subscript is out of range")
      var referencedArray2D = Array2D(container: container[x])
      referencedArray2D.swapDimensions()
      return referencedArray2D
    }
    
    set {
      assert(x >= 0 && x < xCount, "Subscript is out of range")
      assert(newValue.yCount == yCount && newValue.xCount == zCount,
        "Array2D is not the correct size")
      var newValueCopy = Array2D(container: newValue.container)
      newValueCopy.swapDimensions()
      container[x] = newValueCopy.container
    }
  }
  
  subscript(#y: Int) -> Array2D<T> {
    get {
      assert(y >= 0 && y < yCount, "Subscript is out of range")
      var referencedArray: Array<Array<T>> = []
      var referencedArray2D = Array2D<T>(container: referencedArray)
      for var i = 0; i < xCount; i++ {
        referencedArray2D.appendXArray(container[i][y])
      }
      return referencedArray2D
    }
    
    set {
      assert(y >= 0 && y < yCount, "Subscript is out of range")
      assert(newValue.xCount == xCount && newValue.yCount == zCount,
        "Array2D is not the correct size")
      for var i = 0; i < xCount; i++ {
        container[i][y] = newValue[x: i]
      }
    }
  }
  
  subscript(#z: Int) -> Array2D<T> {
    get {
      assert(z >= 0 && z < zCount, "Subscript is out of range")
      var referencedArray: Array<Array<T>> = []
      var referencedArray2D = Array2D<T>(container: referencedArray)
      for var i = 0; i < xCount; i++ {
        var referencedXArray: Array<T> = []
        for var j = 0; j < yCount; j++ {
          referencedXArray.append(container[i][j][z])
        }
        referencedArray2D.appendXArray(referencedXArray)
      }
      return referencedArray2D
    }
    
    set {
      assert(z >= 0 && z < zCount, "Subscript is out of range")
      assert(newValue.xCount == xCount && newValue.yCount == yCount,
        "Array2D is not the correct size")
      for var i = 0; i < xCount; i++ {
        for var j = 0; j < yCount; j++ {
          container[i][j][z] = newValue[i, j]
        }
      }
    }
  }
  
  subscript(#x: Int, #y: Int) -> Array<T> {
    get {
      assert(x >= 0 && x < xCount && y >= 0 && y < yCount,
        "Subscript is out of range")
      return container[x][y]
    }
    
    set {
      assert(x >= 0 && x < xCount && y >= 0 && y < yCount,
        "Subscript is out of range")
      assert(newValue.count == zCount, "Array is not the correct size")
      container[x][y] = newValue
    }
  }
  
  subscript(#x: Int, #z: Int) -> Array<T> {
    get {
      assert(x >= 0 && x < xCount && z >= 0 && z < zCount,
        "Subscript is out of range")
      var referencedArray: Array<T> = []
      for var j = 0; j < yCount; j++ {
        referencedArray.append(container[x][j][z])
      }
      return referencedArray
    }
    
    set {
      assert(x >= 0 && x < xCount && z >= 0 && z < yCount,
        "Subscript is out of range")
      assert(newValue.count == yCount, "Array is not the correct size")
      for var j = 0; j < yCount; j++ {
        container[x][j][z] = newValue[j]
      }
    }
  }
  
  subscript(#y: Int, #z: Int) -> Array<T> {
    get {
      assert(y >= 0 && y < yCount && z >= 0 && z < zCount,
        "Subscript is out of range")
      var referencedArray: Array<T> = []
      for var i = 0; i < xCount; i++ {
        referencedArray.append(container[i][y][z])
      }
      return referencedArray
    }
    
    set {
      assert(y >= 0 && y < yCount && z >= 0 && z < zCount,
        "Subscript is out of range")
      assert(newValue.count == xCount, "Array is not the correct size")
      for var i = 0; i < xCount; i++ {
        container[i][y][z] = newValue[i]
      }
    }
  }
}

struct Stack<T> {
  var container: Array<T>
  var count: Int
  
  init() {
    self.container = []
    count = 0
  }
  
  init(container: Array<T>) {
    self.container = container
    count = container.count
  }
  
  func isEmpty() -> Bool {
    return count == 0
  }
  
  func top() -> T {
    assert(count > 0, "Attempted to call top() on empty Stack")
    return container[count - 1]
  }
  
  mutating func push(item: T) {
    container.append(item)
    count++
  }
  
  mutating func pop() -> T {
    assert(count > 0, "Attempted to call pop() on empty Stack")
    count--
    return container.removeLast()
  }
}

struct Deque<T> {
  var containerBack: Array<T>
  var containerFront: Array<T>
  var count: Int
  
  init() {
    containerBack = []
    containerFront = []
    count = 0
  }
  
  init(deque: Deque<T>) {
    containerBack = deque.containerBack
    containerFront = deque.containerFront
    count = deque.count
  }
  
  init(container: Array<T>) {
    containerBack = container
    containerFront = []
    count = container.count
  }
  
  func isEmpty() -> Bool {
    return count == 0
  }
  
  func front() -> T {
    assert(count > 0, "Attempted to call front() on empty Deque")
    if (containerFront.count > 0) {
      return containerFront[containerFront.count - 1]
    } else {
      return containerBack[0]
    }
  }
  
  func back() -> T {
    assert(count > 0, "Attempted to call back() on empty Deque")
    if (containerBack.count > 0) {
      return containerBack[containerBack.count - 1]
    } else {
      return containerFront[0]
    }
  }
  
  mutating func pushFront(item: T) {
    containerFront.append(item)
    count++
  }
  
  mutating func pushBack(item: T) {
    containerBack.append(item)
    count++
  }
  
  mutating func pushFrontArray(array: Array<T>) {
    for var i = 0; i < array.count; i++ {
      containerFront.append(array[i])
    }
    count += array.count
  }
  
  mutating func pushBackArray(array: Array<T>) {
    for var i = 0; i < array.count; i++ {
      containerBack.append(array[i])
    }
    count += array.count
  }
  
  mutating func popFront() -> T {
    assert(count > 0, "Attempted to call popFront() on empty Deque")
    count--
    if (containerFront.count > 0) {
      return containerFront.removeLast()
    } else {
      return containerBack.removeAtIndex(0)
    }
  }
  
  mutating func popBack() -> T {
    assert(count > 0, "Attempted to call popBack() on empty Deque")
    count--
    if (containerBack.count > 0) {
      return containerBack.removeLast()
    } else {
      return containerFront.removeAtIndex(0)
    }
  }
  
  mutating func insert(item: T, atIndex: Int) {
    assert(atIndex < count && atIndex >= 0, "Index is out of range")
    if (atIndex < containerFront.count) {
      containerFront.insert(item, atIndex: containerFront.count - atIndex)
    } else {
      containerBack.insert(item, atIndex: atIndex - containerFront.count)
    }
  }
  
  mutating func removeAtIndex(index: Int) -> T {
    assert(index < count && index > 0, "Index is out of range")
    if (index < containerFront.count) {
      return containerFront.removeAtIndex(containerFront.count - index)
    } else {
      return containerBack.removeAtIndex(index - containerBack.count)
    }
  }
  
  mutating func shrinkToSize(size: Int) -> Deque<T> {
    var alternator: Bool = Bool(Int(rand()) % 2)
    var removed: Deque<T> = Deque<T>()
    while count > size {
      if alternator {
        removed.pushBack(popBack())
        alternator = !alternator
      } else {
        removed.pushFront(popFront())
        alternator = !alternator
      }
    }
    return removed
  }
  
  mutating func clear() -> Deque<T> {
    var removed = Deque<T>(deque: self)
    self = Deque<T>()
    return removed
  }
  
  func toArray() -> Array<T> {
    var array: Array<T> = []
    var containerFrontCopy = containerFront
    var containerBackCopy = containerBack
    containerFrontCopy.reverse()
    for item in containerFrontCopy {
      array.append(item)
    }
    for item in containerBackCopy {
      array.append(item)
    }
    return array
  }
  
  func indexRangeToArray(#start: Int, end: Int) -> Array<T> {
    assert(start >= 0 && start < count && end >= 0 && end < count &&
      start < end, "Index range is invalid")
    var array: Array<T> = []
    for var i = start; i < end; i++ {
      array.append(self[i])
    }
    return array
  }
  
  mutating func removeIndexRange(#start: Int, end: Int) -> Deque<T> {
    assert(start >= 0 && start < count && end >= 0 && end < count &&
      start < end, "Index range is invalid")
    var array: Array<T> = []
    var i = start
    
    while count - i > count - end {
      array.append(self.removeAtIndex(i))
    }
    return Deque<T>(container: array)
  }
  
  subscript(index: Int) -> T {
    get {
      assert(index < count && index >= 0, "Subscript is out of range")
      if (index < containerFront.count) {
        return containerFront[containerFront.count - index]
      } else {
        return containerBack[index - containerFront.count]
      }
    }
    
    set {
      assert(index < count && index >= 0, "Subscript is out of range")
      if (index < containerFront.count) {
        containerFront[containerFront.count - index] = newValue
      } else {
        containerBack[index - containerFront.count] = newValue
      }
    }
  }
}









