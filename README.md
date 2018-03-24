# MNIST + CoreML
Simple COVNet to predict handwritten digits using Keras + CoreML built for WWDC '18 scholarship submission

![MNIST + CoreML](Assets/Demo.gif)

## Requirements
Xcode 9.0+ or Swift Playground app on iPad

## The Model
A simple convolutional neural network trained on the [MNIST dataset](http://yann.lecun.com/exdb/mnist/).
I was able to get to 99.1% test accuracy after 12 epochs with approx. 3 min per epoch on my Macbook Pro.

- To use the trained model direactly in your code, drag and drop the [**MNIST.mlmodel**](MNIST.mlmodel) file into your Xcode project
- A [**Jupyter notebook**](Jupyter/mnist-covnet.ipynb) is also included if you want to modify the moddel or preffer to train the network on your device.

## Contributing
Your feedback is always appreciated and welcomed. If you find a bug in the source code, you can help me by submitting an issue. Even better you can submit a Pull Request with a fix :)

## Credits and Thanks
- The model was inspired by [mnist_cnn.py](https://github.com/keras-team/keras/blob/master/examples/mnist_cnn.py) by [Keras](https://github.com/keras-team/keras).
- [Udacity](https://www.udacity.com) for their awesome [Deep Learning Nanodegree](https://www.udacity.com/course/deep-learning-nanodegree--nd101) course.
- [Sasmito Adibowo](https://github.com/adib) for his [blog post](https://cutecoder.org/programming/core-ml-swift-playgrounds/) on how to add `.mlmodel` files to Swift Playground.

## License
This project is released under the [MIT](LICENSE) License.
