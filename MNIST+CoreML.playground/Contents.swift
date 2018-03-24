/*:
 # MNIST + CoreML

 The [**MNIST database**](https://en.wikipedia.org/wiki/MNIST_database) is a large database of handwritten digits as 28x28 pixel images created by [Yann LeCun](http://yann.lecun.com/).

 ![MNIST digits example](mnist_digits_example.png)
 */
/*:
# The Model
Our model consists of 12 layers:

1. Input (28x28 image)
2. Conv2D (Relu activation)
3. MaxPooling2D
4. Conv2D (Relu activation)
5. MaxPooling2D
6. Conv2D (Relu activation)
7. MaxPooling2D
8. Dropout (0.3)
9. Flatten
10. Dense
11. Dropout (0.4)
12. Dense (Softmax activation)

![COVNet Model Visualizzation](img_convnet_visualization.png)
*/

/*:
# Handwritten digits classification
Run the code below to start this playground
*/

import UIKit
import PlaygroundSupport

PlaygroundPage.current.liveView = MINSTViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
