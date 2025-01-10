# Swift DispatchGroup Race Condition

This repository demonstrates a race condition that can occur when using `DispatchGroup` with asynchronous network requests in Swift.  The provided code attempts to fetch data from multiple URLs concurrently and handles errors, but due to a race condition, error handling may not always be reliable.

The `bug.swift` file contains the erroneous code, and `bugSolution.swift` demonstrates a corrected approach to handling errors correctly and avoid the race condition.