---
categories: ML
description: LinearRegression
---

线性回归
---

# 线性模型

## 基本形式

线性模型(Linear model)试图学得一个通过属性的线性组合来进行预测的函数，即

$$ f(x)=w_1x_1+w_2x_2+...+w_dx_d+b $$

一般用向量形式写成

$$ f(x)=w^Tx+b $$

其中$ w=(w_1;w_2;...;w_d) $.w和b学得之后，模型就得以确定。

线性模型有很好的可解释性。

## 线性回归

"线性回归" (linear regression)试图学得一个线性模型以尽可能准确地预测实值输出标记。

均方误差(2.2) 是回归任务中最常用的性能度量

均方误差有非常好的几何意义。它对应了常用的欧几里得距离或简称"欧氏距离" (Euclidean distance). 基于均方误差最小化来进行模型求解的方法称为"最小二乘法" (least squ町e method).

在线性回归中，最小二乘法就是试图找到一条直线，使所有样本到直线上的欧氏距离之和最小.

求解w,b过程，称为线性回归模型的最小二乘"参数估计" (parameter estimation).

```python

```

凸函数的任何极小值也是最小值。严格凸函数最多有一个最小值。
[凸函数 - 维基百科，自由的百科全书](https://zh.wikipedia.org/zh-hans/%E5%87%B8%E5%87%BD%E6%95%B0)



---

两种算法：

经典算法——最小二乘法
---

深度学习——梯度下降法
---

用两种方法分别实现了线性回归
项目传到GitHub
[Learn_MXNet/LinearRegression.ipynb at master · arthuryunze/Learn_MXNet](https://github.com/arthuryunze/Learn_MXNet/blob/master/ML%E5%9F%BA%E7%A1%80%E7%BB%83%E4%B9%A0/LinearRegression.ipynb)
[线性回归理解（附纯python实现）_Python_快来学习鸭～～～-CSDN博客](https://blog.csdn.net/sxf1061926959/article/details/66976356)

