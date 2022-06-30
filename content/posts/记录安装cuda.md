---
title: "记录安装cuda"
date: 2021-03-04T16:57:58+08:00
draft: false
---

# 记录安装cuda

## 获取下载命令：

进入官网

https://developer.nvidia.com/zh-cn/cuda-downloads

依次选择：Linux、x86、Ubuntu、20.04、runfile

获取下载命令：

```bash
wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda_11.1.0_455.23.05_linux.run
sudo sh cuda_11.1.0_455.23.05_linux.run
```

## 安装

由于已经安装了显卡驱动，因此在安装时将驱动取消打勾。

安装完成后，显示提示。

```
===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-11.1/
Samples:  Installed in /home/yunze/, but missing recommended libraries

Please make sure that
 -   PATH includes /usr/local/cuda-11.1/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-11.1/lib64, or, add /usr/local/cuda-11.1/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-11.1/bin
***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least .00 is required for CUDA 11.1 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run --silent --driver

Logfile is /var/log/cuda-installer.log
```

按照提示修改`.bashrc`文件。在文件末尾添加：

```
export LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH=/usr/local/cuda-11.1/bin:/usr/local/cuda-11.1/nsight-compute-2020.2.0${PATH:+:${PATH}}
```

使配置生效

```text
source ~/.bashrc
```

进入`/usr/local/cuda-11.1/samples/1_Utilities/deviceQuery`目录

```text
sudo make
./deviceQuery
```

出现以下提示即安装成功。

```text
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GTX 960M"
  CUDA Driver Version / Runtime Version          11.0 / 11.1
  CUDA Capability Major/Minor version number:    5.0
  Total amount of global memory:                 2004 MBytes (2101870592 bytes)
  ( 5) Multiprocessors, (128) CUDA Cores/MP:     640 CUDA Cores
  GPU Max Clock rate:                            1176 MHz (1.18 GHz)
  Memory Clock rate:                             2505 Mhz
  Memory Bus Width:                              128-bit
  L2 Cache Size:                                 2097152 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total shared memory per multiprocessor:        65536 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Managed Memory:                Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 11.0, CUDA Runtime Version = 11.1, NumDevs = 1
Result = PASS

```

---

## reference

[Ubuntu 18.04安装CUDA和cuDNN - 知乎](https://zhuanlan.zhihu.com/p/72298520)