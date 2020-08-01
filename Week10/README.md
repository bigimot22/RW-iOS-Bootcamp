<!-- Header -->
<h1>AnimationGroup</h1>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)

<!-- Body -->
## RW iOS Bootcamp Assigment 10

This week we went deep into **GCD**  and learn all about threads, concurrency and sycronous and asyncronous execution. To practice, we have to solve a couple of tasks in a playground. 
Since UIView.animate is asynchronous, it doesn't make it easy to determine when multiple simultaneous animations have completed. So, I use GCD dispatch groups to be notified when a set of animations have completed by extending the UIView animation API to accept a DispatchGroup as argument, and thus determine when a all animations have completed.
Done specifically for assigment 10 of the firsts ever RW iOS Bootcamp at https://www.raywenderlich.com/10529048-ios-bootcamp.



<!-- Footer -->
## Tech
- Swift 5
- Foundation
- UIKit
- iOS 13
- GCD
