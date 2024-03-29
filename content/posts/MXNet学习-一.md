---
title: "MXNet学习-一"
date: 2020-02-20T16:57:58+08:00
draft: false
---

---
description: Learn MXNet 1
categories: ML MXNet
---

---

系统环境：  
Windows10  
python3  
MXNet v1.5.1 cpu版本  
Anaconda
jupyterLab 1.2.6

---

国际惯例，从mnist数据集开始。

Loading Data——导入mnist手写体数据集
---

```python
import mxnet as mx

# Fixing the random seed
mx.random.seed(42)

mnist = mx.test_utils.get_mnist()
```

注意，Windows环境下，运行完成后将在当前目录下载四个.qz格式文件，若下载被中断，则无法运行后续代码。

解决方法：删除不完整的.qz文件从新下载。Linux系统下该文件位置在~/.keras/datasets路径下，使用命令`rm -rf "dataset name"`删除。

```python
# 训练批次
batch_size = 100
# 初始化两个迭代器，一个用于训练数据，另一个用于测试数据。
train_data = mx.io.NDArrayIter(mnist['train_data'], mnist['train_label'], batch_size, shuffle=True)
val_data = mx.io.NDArrayIter(mnist['test_data'], mnist['test_label'], batch_size)
```

`MXNet Data iterators`： MXNet数据迭代器  
对于大批量数据，不可能预加载整个数据集，MXNet Data iterators可将输入数据*流式传输*到MXNet训练算法中。

一个批次的图像通常表示为一个4维数组(batch_size, num_channels, width, height)


Approaches——方法(CNN)
---

CNN主要由两种网络层构成：  
卷积层和池化层

### 卷积层

单个卷积层由一个或多个过滤器组成，每个过滤器起*特征检测器(feature detector)*的作用。

在训练过程中，CNN*学习*这些过滤器的适当表示形式(参数)。

CNN通过应用*非线性函数*对卷积层的输出进行*转换(transform)*。

### 池化层

A pooling layer serves to make the CNN translation invariant  
池化层的作用是使CNN转换不变(平移不变性 转化不变性 惰性 降低敏感度)

即使左/右/上/下移动几个像素，数字仍保持不变

池化层将一个 $n \times m$ 的小片(区域)缩减为一个值，使网络对空间位置不那么敏感。在CNN的每个conv(+激活)层之后总是包含池化层。

### LeNet

LeNet: a cnn architecture  
是一个很受欢迎的网络，它可以很好地完成数字分类任务。

我们将使用与原始LeNet实现稍有不同的版本，将神经元的sigmoid激活替换为tanh激活。

### implementation on MXNet

一种典型的方法来写你的网络，这种方法是创建一个新类继承gluon.Block

我们可以通过组合和继承Block类来定义网络。

```python
import mxnet.ndarray as F

class Net(gluon.Block):
    def __init__(self, **kwargs):
        super(Net, self).__init__(**kwargs)
        with self.name_scope():
            # layers created in name_scope will inherit name space
            # from parent layer.
            self.conv1 = nn.Conv2D(20, kernel_size=(5,5))
            self.pool1 = nn.MaxPool2D(pool_size=(2,2), strides = (2,2))
            self.conv2 = nn.Conv2D(50, kernel_size=(5,5))
            self.pool2 = nn.MaxPool2D(pool_size=(2,2), strides = (2,2))
            self.fc1 = nn.Dense(500)
            self.fc2 = nn.Dense(10)

    def forward(self, x):
        x = self.pool1(F.tanh(self.conv1(x)))
        x = self.pool2(F.tanh(self.conv2(x)))
        # 0 means copy over size from corresponding dimension.
        # -1 means infer size from the rest of dimensions.
        x = x.reshape((0, -1))
        x = F.tanh(self.fc1(x))
        x = F.tanh(self.fc2(x))
        return x
```

我们这里只是定义了前向函数，计算梯度的后向函数是(使用autograd为您)自动定义的。

现在，创建网络。

```python
net = Net()
```

![First conv + pooling layer in LeNet.](https://raw.githubusercontent.com/dmlc/web-data/master/mxnet/image/conv_mnist.png)

下一节将开始训练模型。

Reference:
---

[Handwritten Digit Recognition — Apache MXNet documentation](https://mxnet.apache.org/api/python/docs/tutorials/packages/gluon/image/mnist.html)