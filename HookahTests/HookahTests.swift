//
//  HookahTests.swift
//  HookahTests
//
//  Created by khoi on 1/16/16.
//  Copyright © 2016 Khoi Lai. All rights reserved.
//

import XCTest
@testable import Hookah

class HookahTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirst() {
    
        if let result = Hookah.first([1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 1)
        }
        XCTAssertNil(Hookah.first([Int]()))
        
    }
    
    func testHead() {
        
        if let result = Hookah.head([1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 1)
        }
        XCTAssertNil(Hookah.head([Int]()))
        
    }

    
    func testLast(){
        if let result = Hookah.last([1, 2, 3, 4, 5, 6]) {
            XCTAssertEqual(result, 6)
        }
        XCTAssertNil(Hookah.last([Int]()))
        
      
    }
    
    func testInclude(){
        XCTAssertEqual(Hookah.includes([1,2,3,4,5], value: 5), true, "Should include")
        XCTAssertEqual(!Hookah.includes([1,2,3,4,5], value: 10), true, "Should include")

    }
    
    func testSlice() {
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 0, end: 2), [1, 2])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 0), [1, 2, 3, 4, 5])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 3), [4, 5])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 8), [])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 8, end: 10), [])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 1, end: 1), [])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 8 , end: 2), [])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 3, end: 3), [])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 2, end: 5), [3,4,5])
        XCTAssertEqual(Hookah.slice([1,2,3,4,5], start: 0, end: 9), [1,2,3,4,5])
    }
    
    func testMap(){
        let doubleArray = Hookah.map([1,2,3,4,5]) { $0 * 2 }
        let arrayString = Hookah.map(["a","b","c"]) { "Hello \($0)" }
        XCTAssertEqual(doubleArray, [2,4,6,8,10], "Double the array")
        XCTAssertEqual(arrayString, ["Hello a","Hello b","Hello c"], "Append string to the array")

    }
    
    func testCompact(){
        XCTAssertEqual(Hookah.compact([2,3,4,nil,6,7]), [2,3,4,6,7])
    }
    
    func testChunk(){
        XCTAssertEqual(Hookah.chunk([] as [NSObject], size: 2), [], "chunk for empty array returns an empty array");
        XCTAssertEqual(Hookah.chunk([1, 2, 3],size: 0), [], "chunk into parts of 0 elements returns empty array");
        XCTAssertEqual(Hookah.chunk([1, 2, 3],size: -1), [], "chunk into parts of negative amount of elements returns an empty array");
        XCTAssertEqual(Hookah.chunk([1, 2, 3]), [], "defaults to empty array (chunk size 0)");
        XCTAssertEqual(Hookah.chunk([1, 2, 3],size: 1), [[1], [2], [3]], "chunk into parts of 1 elements returns original array");
        XCTAssertEqual(Hookah.chunk([1, 2, 3],size: 3), [[1, 2, 3]], "chunk into parts of current array length elements returns the original array");
        XCTAssertEqual(Hookah.chunk([1, 2, 3],size: 5), [[1, 2, 3]], "chunk into parts of more then current array length elements returns the original array");
        XCTAssertEqual(Hookah.chunk([10, 20, 30, 40, 50, 60, 70],size: 2), [[10, 20], [30, 40], [50, 60], [70]], "chunk into parts of less then current array length elements");
        XCTAssertEqual(Hookah.chunk([10, 20, 30, 40, 50, 60, 70],size: 3), [[10, 20, 30], [40, 50, 60], [70]], "chunk into parts of less then current array length elements");
    }
    
    func testConcat(){
        let array = [1]
        XCTAssertEqual(Hookah.concat(array, values: 2, 3, 4), [1,2,3,4], "Should concat values")
        XCTAssertEqual(Hookah.concat(array, arrays: [1,2],[3,4],[0]), [1,1,2,3,4,0], "Should concat arrays")
    }
    
    func testContains(){
        let arrayString = ["asd","test","123"]
        let arrayNumber = [1,2,3,4,5]
        Hookah.contains(arrayString, value: "asd")
        XCTAssert(Hookah.contains(arrayString, value: "asd"), "Should contain string")
        XCTAssert(!Hookah.contains(arrayString, value: "3"), "Should NOT contain string")
        XCTAssert(Hookah.contains(arrayNumber, value: 4), "Should contain number")
        XCTAssert(!Hookah.contains(arrayNumber, value: 40), "Should NOT contain number")
    }
    
    func testFilter(){
        let arr = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.filter(arr){ $0 % 2 == 0 }, [2,4,6,8], "Even array")
    }
    
    func testEvery(){
        XCTAssert(Hookah.every([true, true, true], predicate: { $0 == true }), "every true values");
        XCTAssert(!Hookah.every([true, false, true], predicate: { $0 == true }), "one false value");
        XCTAssert(Hookah.every([0, 10, 28], predicate: { $0 % 2 == 0 }), "even numbers");
        XCTAssert(!Hookah.every([0, 11, 28], predicate: { $0 % 2 == 0 }), "an odd number");
    }
    
    func testSome(){
        XCTAssert(Hookah.some([true, false, true], predicate: { $0 == true }), "one false value");
        XCTAssert(!Hookah.some([false, false, false], predicate: { $0 == true }), "all true value");
        XCTAssert(Hookah.some([11, 10, 22], predicate: { $0 % 2 == 0 }), "even numbers");
        XCTAssert(!Hookah.some([3, 11, 25], predicate: { $0 % 2 == 0 }), "an odd number");

    }
    
    func testFind(){
        let array = [1, 2, 3, 4];
        XCTAssertEqual(Hookah.find(array){ $0 % 2 == 0 }, 2, "Should return the first founded value")
        XCTAssertEqual(Hookah.find(array){ $0 == 3 }, 3, "Should return the first founded value")
        XCTAssertEqual(Hookah.find(array){ $0 == false }, nil, "Should return nil when value not found")
    }
    
    func testFindLast(){
        let array = [1, 2, 3, 4];
        Hookah.findLast(["a","b","c"]) { (element) -> Bool in
            element == "c"
        }
        XCTAssertEqual(Hookah.findLast(array){ $0 % 2 == 0 }, 4, "Should return the last founded value")
        XCTAssertEqual(Hookah.findLast(array){ $0 == 3 }, 3, "Should return the last founded value")
        XCTAssertEqual(Hookah.findLast(array){ $0 == false }, nil, "Should return nil when value not found")
    }
    
    func testGroupBy(){
        let arr = [1,2,3,4,5]
        let test = Hookah.groupBy(arr){ $0 % 2 == 0 ? "even" : "odd" }
        XCTAssertEqual(test["even"]!, [2,4], "SHould have even group")
        XCTAssertEqual(test["odd"]!, [1,3,5], "SHould have odd group")
    }

    func testReduce(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.reduce(arr, initial: 0, combine: +), 15, "Should sum up value")
        XCTAssertEqual(Hookah.reduce(arr, initial: 1, combine: +), 16, "Should sum up value using default value")
        XCTAssertEqual(Hookah.reduce(arr, initial: 1, combine: *), 120, "Should multiplied up value")
        let test = Hookah.reduce(["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
        XCTAssert(test == "foobarbaz", "Should combine string")
    }
    
    func testReduceRight(){
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Hookah.reduceRight(arr, initial: 0, combine: +), 15, "Should sum up value")
        XCTAssertEqual(Hookah.reduceRight(arr, initial: 1, combine: +), 16, "Should sum up value using default value")
        XCTAssertEqual(Hookah.reduceRight(arr, initial: 1, combine: *), 120, "Should multiplied up value")
        let test = Hookah.reduceRight(["foo","bar","baz"], initial: "") {return "\($0)\($1)" }
        XCTAssertEqual(test, "bazbarfoo", "Should combine string")

    }
    
    func testReject(){
        let arr = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.reject(arr){ $0 % 2 == 0 }, [1,3,5,7,9], "should return odd array")

    }
    
    
    
    func testSample(){
        let arr = [1]
        let arr2 = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.sample(arr), 1, "Should return first sample")
        let sample = Hookah.sample(arr2)
        XCTAssert(Hookah.some(arr2) {  $0 == sample })
        
        
    }
    
    func testSampleSize(){
        let arr = [1]
        let arr2 = [1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(Hookah.sampleSize(arr, n: 1), [1], "Should return first sample")
        XCTAssertEqual(Hookah.sampleSize(arr, n: 0), [], "Should return first sample")
        
        let sampleSize = Hookah.sampleSize(arr2, n: 4)
        XCTAssertEqual(sampleSize.count, 4, "Should pick correct amount of array")
        
        Hookah.every(sampleSize, predicate: { element in
            Hookah.some(arr2, predicate: { $0 == element })
        })
    }
    
    func testSize(){
        let arr = [1,2,3,4]
        XCTAssertEqual(Hookah.size(arr), 4)
        XCTAssertEqual(Hookah.size([] as [NSObject]), 0)

    }
    
    func testShuffle(){
        let arr = [1,2,3,4,5,6,7,9,8]
        Hookah.every(arr) { (element) -> Bool in
            Hookah.some(Hookah.shuffle(arr), predicate: { element == $0 })
        }
        XCTAssert(Hookah.every(arr) { (element) -> Bool in
            Hookah.some(Hookah.shuffle(arr), predicate: { element == $0 })
            }, "Should shuffle the arraay")
        
    }
    
    func testFlattenDeep(){
        let arr = [1,2,3,4,5,[6,7],[8],[9]]
        XCTAssertEqual(Hookah.flattenDeep(arr), [1,2,3,4,5,6,7,8,9], "Should flatten array")
        XCTAssertEqual(Hookah.flattenDeep([[1],2,[3,[[4]],5],[[6,7],8],[[9]]]  ), [1,2,3,4,5,6,7,8, 9], "Should deeply flatten the array")
    }
    
    func testRandom() {
        let random = Hookah.random()
        XCTAssert(Hookah.some([0, 1]) {$0 == random}, "Should return 0 or 1")
        XCTAssertEqual(Hookah.random(lower:2,upper:2), 2, "Should return 2")
    }
}
