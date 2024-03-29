---
title: "Softmax函数"
date: 2020-02-20T16:57:58+08:00
draft: false
---

---
categories: ML
description: An introduction to Softmax func.
---


Softmax函数
---
在数学，尤其是概率论和相关领域中，Softmax函数，或称归一化指数函数，是逻辑函数的一种推广。它能将一个含任意实数的K维向量z “压缩”到另一个K维实向量$ \sigma{z} $中，使得每一个元素的范围都在(0,1)之间，并且所有元素的和为1(也可视为一个 (k-1)维的hyperplan，因为总和为1，所以是subspace)。该函数的形式通常按下面的式子给出：

$$ {\displaystyle \sigma (\mathbf {z} )_{j}={\frac {e^{z_{j}}}{\sum _{k=1}^{K}e^{z_{k}}}}}    for j = 1, …, K. $$

Python example：
```python
>>> import numpy as np
>>> a = [1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0]
>>> np.exp(a) / np.sum(np.exp(a)) 
array([0.02364054, 0.06426166, 0.1746813, 0.474833, 0.02364054,0.06426166, 0.1746813])
```

Reference:
---
[Softmax函数 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/Softmax%E5%87%BD%E6%95%B0)
