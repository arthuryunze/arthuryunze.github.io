---
title: "Face-Detection(MTCNN)"
date: 2020-02-23T16:57:58+08:00
draft: false
---

---
categories: ML mxnet
description: learn Face Detection(MTCNN) with Deep Learning 1
---

Face Detection
---

### 人脸检测  

对于人类而言，这是一个微不足道的问题，近来也已经被经典的基于特征的技术（例如级联分类器）合理地解决了。最近，深度学习方法已在标准的基准人脸检测数据集上取得了最先进的结果。一个例子是多任务级联卷积神经网络(Multi-task Cascade Convolutional Neural Network)，简称MTCNN。

### MTCNN网络结构

该网络使用具有三个网络的级联结构。 首先将图像缩放到不同大小的范围（称为图像金字塔），然后第一个模型（建议网络或P-Net）提出候选的面部区域，第二个模型（Refine网络或R-Net）过滤边界框 ，第三个模型（输出网络或O-Net）提出了人脸标志。
> 第一个网络是一个浅层神经网络（后简称pnet） => 产生初步候选框
第二个网络是一个“more complex CNN“相较pnet更为复杂的网络（后简称rnet）=> 从初步候选框中筛选掉大量的不包括人脸的框  
第三个网络是一个“more powerful CNN”相较rnet更为强大的网络（后简称onet）=> 进一步优化结果以及产生五个面部特征点（双眼，鼻尖，嘴角）

mtcnn库
---
GitHub上发现，已经有同学做好了MTCNN相应的库  
[ipazc/mtcnn: MTCNN face detection implementation for TensorFlow, as a PIP package.](https://github.com/ipazc/mtcnn)

我们先简单使用一下：  
用笔记本自带摄像头拍摄一张照片，用opencv库导入。

```python
from mtcnn import MTCNN
import cv2
img = cv2.cvtColor(cv2.imread("WIN_20200223_17_44_49_Pro.jpg"), cv2.COLOR_BGR2RGB)
detector = MTCNN()
detector.detect_faces(img)
```

我们可以得到一个list格式的数据

```
[{'box': [480, 214, 234, 309],
  'confidence': 0.9999535083770752,
  'keypoints': {'left_eye': (536, 330),
   'right_eye': (643, 334),
   'nose': (583, 402),
   'mouth_left': (543, 453),
   'mouth_right': (633, 456)}}]
```

从这个list可以看出  
box是人脸框的矩形坐标
confidence 置信度，照片中有人脸的可能性为这个值  
keypoints参数中分别是左眼，右眼，鼻子，嘴巴左侧，嘴巴右侧的位置。

---

效果很好，下一节使用我们将使用mxnet实现MTCNN。

