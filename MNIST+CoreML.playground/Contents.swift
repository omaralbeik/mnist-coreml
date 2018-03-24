
/*:
 # MNIST + CoreML

 The [**MNIST database**](https://en.wikipedia.org/wiki/MNIST_database) is a large database of handwritten digits as 28x28 pixel images.

 ![MNIST digits example](mnist_digits_example.png)

 */

import UIKit
import PlaygroundSupport

let liveView = MNISTView(frame: .init(x: 0, y: 0, width: 600, height: 800))
PlaygroundPage.current.liveView = liveView
PlaygroundPage.current.needsIndefiniteExecution = true
