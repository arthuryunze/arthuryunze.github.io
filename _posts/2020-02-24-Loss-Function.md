---
categories: ML mxnet
description: learn Face Detection(MTCNN) with Deep Learning 2
---

What’s a Loss Function?
---
什么是损失函数？

At its core, a loss function is incredibly simple: it’s a method of evaluating how well your algorithm models your dataset.  
损失函数的核心非常简单：它是评价你的算法效果有多好的方法。

Different Types and Flavors of Loss Functions
---
A lot of the loss functions that you see implemented in machine learning can get complex and confusing. Consider this paper from late 2017, entitled A Semantic Loss Function for Deep Learning with Symbolic Knowledge. There’s more in that title that I don’t understand than I do. But if you remember the end goal of all loss functions–measuring how well your algorithm is doing on your dataset–you can keep that complexity in check.  
We’ll run through a few of the most popular loss functions currently being used, from simple to more complex.

损失函数的不同类型和风格  
你在机器学习中看到的很多损失函数可能会变得复杂和令人困惑。以2017年底发表的一篇论文为例，题为《符号知识深度学习的语义损失函数》(A Semantic Loss Function for Deep Learning with Symbolic Knowledge)。那个标题里有很多东西我都不明白。但是如果你记得所有损失函数的最终目标，即测量你的算法在数据集上的表现，你就可以控制复杂度。  
我们将介绍当前使用的一些最流行的损失函数，从简单到复杂。

### Mean Squared Error

Mean Squared Error (MSE)   
均方误差（MSE）是基本损失函数的主力军：它易于理解和实施，并且通常运行良好。 要计算MSE，您需要将预测值与基本事实之间的差值求平方，然后在整个数据集中求平均值。

### Likelihood Loss

可能性损失，似然损失

似然函数也相对简单，通常用于分类问题。  
例如，考虑一个模型，该模型针对[0，1，1，0]的地面真相标签输出概率为[0.4，0.6，0.9，0.1]。 似然损失将计算为（0.6）*（0.6）*（0.9）*（0.9）= 0.2916。 由于模型仅输出TRUE（或1）的概率，因此当地面真实标签为0时，我们将（1-p）作为概率。 换句话说，我们将模型的输出概率相乘以获得实际结果。

### Log Loss (Cross Entropy Loss)

对数损失是一种损失函数，在分类问题中也经常使用，它是Kaggle竞赛中最受欢迎的度量之一。 这只是对数函数对数的直接修改。它只是用对数直接修改了似然函数。

Loss Functions and Optimizers
---

损失函数不仅提供模型运行情况的静态表示，而且还表示算法首先适合数据。 大多数机器学习算法都会在优化过程中使用某种损失函数，或者为您的数据找到最佳参数（权重）。

就像针对独特问题的损失函数有不同的风格一样，也不乏各种优化器。 这超出了本文的范围，但从本质上讲，损失函数和优化器可以协同工作，以使算法尽可能以最佳方式适合您的数据。


理解：
loss func 算偏差的
optimizer algorithm 调参 优化偏差的
机器学习： 拟合一个高维函数的过程
loss反馈 oa调整
归纳整理

Reference：
---
[Introduction to Loss Functions | Algorithmia Blog](https://algorithmia.com/blog/introduction-to-loss-functions)