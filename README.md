Hookah [![Build Status](https://travis-ci.org/khoiln/Hookah.svg?branch=master)](https://travis-ci.org/khoiln/Hookah) ![CocoaPods](https://img.shields.io/cocoapods/v/Hookah.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
===========
Hookah is a functional library for Swift. It's inspired by Lo-Dash project.

# API Documentation #

## CollectionType ##

### `Hookah.each` -> `Hookah.forEach`
```swift
Hookah.every<T where T:CollectionType>(collection: T, predicate: T.Generator.Element throws -> Bool) rethrows -> Bool
```

Iterates over elements of collection invoking iteratee function on each element.

#### Alias ####
- Hookah.forEach

#### Arguments ####
- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####
- Void

#### Example ####
```swift
Hookah.each([1,2]){ print($0) }
// → log `1` then `2`

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.each(scores){ print($0.0) }
// -> log `khoi` then `quan` then `toan`
```

### `Hookah.eachRight` -> `Hookah.forEachRight`
```swift
Hookah.eachRight<T where T:CollectionType, T.Index == Int>(collection: T,@noescape iteratee: T.Generator.Element throws -> ()) rethrows
```

This is like Hookah.each except that it iterates over elements of collection from right to left.

#### Alias ####
- Hookah.forEachRight

#### Arguments ####
- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####
- Void

#### Example ####
```swift
Hookah.eachRight([1,2]){ print($0) }
// → log `2` then `1`
```

### `Hookah.every` -> `Hookah.every`
```swift
Hookah.every<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> Bool
```

Checks if predicate returns true for all elements of collection. Iteration is stopped once predicate returns false.

#### Arguments ####

- collection: The collection to iterate over.
- iteratee:   The function invoked per iteration.

#### Return ####

Returns true if all elements pass the predicate check, else false.

#### Example ####
```swift
Hookah.every([0, 10, 28]){ $0 % 2 == 0 }
// -> true

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.every(scores){ $0.1 > 50 }
// -> false
```

### `Hookah.filter`
```swift
Hookah.filter<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> [T.Generator.Element]
```

Iterates over elements of collection, returning an array of all elements predicate returns true for.

#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the new filtered array.

#### Example ####
```swift
Hookah.filter([1, 2, 4]){ $0 % 2 == 0 }
// -> [2,4]

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.filter(scores){ $0.1 > 50 }
// -> [("khoi", 82), ("toan", 90)]
```

### `Hookah.find`
```swift
Hookah.find<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> T.Generator.Element?
```

Iterates over elements of collection, returning the first element predicate returns true for.

#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the matched element, else nil.

#### Example ####
```swift
Hookah.find([1, 2, 4]){ $0 % 2 == 0 }
// -> Optional(2)

let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.find(scores){ $0.0 == "khoi" }
// -> Optional(("khoi", 82))
```

### `Hookah.findLast`
```swift
Hookah.findLast<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> T.Generator.Element?
```

This is like Hookah.find except it iterates over the elements of the collection from right to left
#### Arguments ####

- collection: The collection to iterate over.
- predicate:   The function invoked per iteration.

#### Return ####

Returns the matched element, else nil.

#### Example ####
```swift
Hookah.findLast([1, 2, 4]){ $0 % 2 == 0 }
// -> 4
```

### `Hookah.groupBy`
```swift
Hookah.groupBy<T where T:CollectionType>(collection: T, @noescape iteratee: T.Generator.Element throws -> String) rethrows -> [String: [T.Generator.Element]]
```

Create a dictionary where the key is a string got by run iteratee through the element, and the value is the arrays of the elements responsible for getting that key
#### Arguments ####

- collection: The collection to iterate over.
- iteratee:   The iteratee invoked per element.

#### Return ####

Returns the dictionary [String: [T]]

#### Example ####
```swift
Hookah.groupBy([1,2,3,4,5]){ $0 % 2 == 0 ? "even" : "odd" }
// -> ["odd": [1, 3, 5], "even": [2, 4]]
```

### `Hookah.includes`
```swift
Hookah.includes<T where T: CollectionType, T.Generator.Element: Equatable>(collection: T, value: T.Generator.Element) -> Bool
```

Return true if value is presented in the collection.
#### Arguments ####

- collection: The collection to iterate over.
- value:   The value to check.

#### Return ####

Boolean determined whether the value is presented.

#### Example ####
```swift
Hookah.includes([1,2,3,4,5], value: 5)
// -> true
```

### `Hookah.map`
```swift
Hookah.map<T: CollectionType, E>(collection: T,@noescape transform: T.Generator.Element throws -> E ) rethrows -> [E]
```

Creates an array of values by running each element in collection through a transform function.
#### Arguments ####

- collection: The collection to iterate over.
- transform:   The function invoked on each element of the collection.

#### Return ####

The new mapped array.

#### Example ####
```swift
func double(a: Int) -> Int{
    return a * 2
}
Hookah.map([1,2,3,4], transform: double)
// -> [2,4,6,8]
```

### `Hookah.reduce`
```swift
Hookah.reduce<T,E where T:CollectionType>(collection: T,initial: E,  @noescape combine: (E, T.Generator.Element) throws -> E) rethrows -> E
```

Reduces collection to a value which is the accumulated result of running each element in collection through iteratee, where each successive invocation is supplied the return value of the previous.
#### Arguments ####

- collection: The collection to iterate over.
- initial:    The initial value.
- combine:    The function invoked per iteration

#### Return ####

Returns the accumulated value.

#### Example ####
```swift
Hookah.reduce([1,2,3], initial: 0) { $0 + $1 }
// -> 6
// Thanks for Swift Operator we can do this as well
Hookah.reduce([1,2], initial: 0, combine: +)
// -> 3
```

### `Hookah.reduceRight`
```swift
Hookah.reduceRight<T,E where T:CollectionType>(collection: T,initial: E,  @noescape combine: (E, T.Generator.Element) throws -> E) rethrows -> E
```

This method is like Hookah.reduce except that it iterates over elements of collection from right to left.
#### Arguments ####

- collection: The collection to iterate over.
- initial:    The initial value.
- combine:    The function invoked per iteration

#### Return ####

Returns the accumulated value.

#### Example ####
```swift
Hookah.reduceRight(["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
// -> "bazbarfoo"
```

### `Hookah.reject`
```swift
Hookah.reject<T where T:CollectionType>(collection: T,@noescape predicate: T.Generator.Element throws -> Bool) rethrows -> [T.Generator.Element]
```

The opposite of Hookah.filter; this method returns the elements of collection that predicate does not return true for.
#### Arguments ####

- collection: The collection to iterate over.
- predicate:  The function invoked per iteration.

#### Return ####

Returns the new filtered array.
 
#### Example ####
```swift
Hookah.reject([1,2,3,4,5]){ $0 % 2 == 0 }
// -> [1,3,5]
let scores = ["khoi" : 82, "quan" : 40, "toan": 90]
Hookah.reject(scores) {$0.1 < 50}
// -> [("khoi", 82), ("toan", 90)]
```

### `Hookah.sample`
```swift
Hookah.sample<T where T:CollectionType, T.Index == Int>(collection: T) -> T.Generator.Element
```

Gets a random element from collection.
#### Arguments ####

- collection: The collection to sample

#### Return ####

Return the random element.
 
#### Example ####
```swift
Hookah.sample([1,2,3,4])
// -> 2
```

### `Hookah.sampleSize`
```swift
Hookah.sampleSize<T where T:CollectionType, T.Index == Int>(collection: T, n: Int) -> [T.Generator.Element]
```

Gets n random elements from collection.

Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).

#### Arguments ####

- collection: The collection to sample
- n:          The number of elements to sample. 0 by default.

#### Return ####

Array of random elements
 
#### Example ####
```swift
Hookah.sampleSize([1,2,3,4],n: 2)
// -> [2,4]
```

### `Hookah.shuffle`
```swift
Hookah.shuffle<T where T:CollectionType, T.Index == Int>(collection: T) -> [T.Generator.Element]
```

Creates an array of shuffled values.

Using [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle).

#### Arguments ####

- collection: The collection to shuffle

#### Return ####

Returns the shuffled array.
 
#### Example ####
```swift
Hookah.shuffle([1,2,3,4])
// -> [2,4,1,3]
```
