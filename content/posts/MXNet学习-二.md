---
title: "MXNet学习-二"
date: 2020-02-21T16:57:58+08:00
draft: false
---

---
description: Learn MXNet 2
categories: ML MXNet
---

在上一节，我们已经搭好了LeNet。

现在，我们要开始使用数据训练这个网络，以使它找到合适的参数。

我们将使用超参数训练LeNet。

若使用GPU进行运算，我们只需要将mx.cpu()更改为mx.gpu()，而MXNet会处理其余的工作。我们将在10个时间段(epoch)后停止训练。

> 建议使用GPU进行运算，LeNet比MLP(多层感知机)更复杂，计算量更大。GPU可大大加快计算速度。

> 为了方便，我的环境使用了CPU版本的MXNet。速度会稍慢，但不影响后续代码。
>> 注意CPU版本和GPU版本安装时是不同的，安装步骤可以查看MXNet官网。  

### Initialize parameters and optimizer——初始化参数和优化器

初始化网络参数如下：

```python
# set the context on GPU is available otherwise CPU
ctx = [mx.gpu() if mx.test_utils.list_gpus() else mx.cpu()]
net.initialize(mx.init.Xavier(magnitude=2.24), ctx=ctx)
trainer = gluon.Trainer(net.collect_params(), 'sgd', {'learning_rate': 0.03})
```

### Training——训练

```python
# Use Accuracy as the evaluation metric.
metric = mx.metric.Accuracy()
softmax_cross_entropy_loss = gluon.loss.SoftmaxCrossEntropyLoss()

for i in range(epoch):
    # Reset the train data iterator.
    train_data.reset()
    # Loop over the train data iterator.
    for batch in train_data:
        # Splits train data into multiple slices along batch_axis
        # and copy each slice into a context.
        data = gluon.utils.split_and_load(batch.data[0], ctx_list=ctx, batch_axis=0)
        # Splits train labels into multiple slices along batch_axis
        # and copy each slice into a context.
        label = gluon.utils.split_and_load(batch.label[0], ctx_list=ctx, batch_axis=0)
        outputs = []
        # Inside training scope
        with ag.record():
            for x, y in zip(data, label):
                z = net(x)
                # Computes softmax cross entropy loss.
                loss = softmax_cross_entropy_loss(z, y)
                # Backpropogate the error for one iteration.
                loss.backward()
                outputs.append(z)
        # Updates internal evaluation
        metric.update(label, outputs)
        # Make one step of parameter update. Trainer needs to know the
        # batch size of data to normalize the gradient by 1/batch_size.
        trainer.step(batch.data[0].shape[0])
    # Gets the evaluation result.
    name, acc = metric.get()
    # Reset evaluation result to initial state.
    metric.reset()
    print('training acc at epoch %d: %s=%f'%(i, name, acc))
```

### Prediction——预测

最后，我们将使用训练好的LeNet模型来生成对测试数据的预测。

```python
%%time
epoch = 10
metric = mx.metric.Accuracy()
# Reset the validation data iterator.
val_data.reset()
# Loop over the validation data iterator.
for batch in val_data:
    # Splits validation data into multiple slices along batch_axis
    # and copy each slice into a context.
    data = gluon.utils.split_and_load(batch.data[0], ctx_list=ctx, batch_axis=0)
    # Splits validation label into multiple slices along batch_axis
    # and copy each slice into a context.
    label = gluon.utils.split_and_load(batch.label[0], ctx_list=ctx, batch_axis=0)
    outputs = []
    for x in data:
        outputs.append(net(x))
    # Updates internal evaluation
    metric.update(label, outputs)
print('validation acc: %s=%f'%metric.get())
assert metric.get()[1] > 0.98
```

如果一切顺利，我们将看到使用LeNet进行预测的更高精度度量。  
有了CNN，我们应该能够正确预测98%的测试图像。

### 总结——Summary

在本教程中，我们学习了如何使用MXNet解决一个标准的计算机视觉问题:对手写数字的图像进行分类。您已经了解了如何使用MXNet胶子包快速、轻松地构建、培训和评估MLP和CNN等模型。


本实验已上传至Github。  
[Learn_MXNet/mnist-mxnet.ipynb at master · arthuryunze/Learn_MXNet](https://github.com/arthuryunze/Learn_MXNet/blob/master/mnist-mxnet.ipynb)
