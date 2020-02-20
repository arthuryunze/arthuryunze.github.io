---
description: 给GitHub Pages添加数学公式支持(Mathjax)
categories: Github math
---
首先介绍一下Mathjax,一个开源js引擎,用于在浏览器中显示数学公式.

Mathjax
---
[MathJax | Beautiful math in all browsers.](https://www.mathjax.org/#gettingstarted)

A JavaScript display engine for mathematics that works in all browsers.

No more setup for readers. It just works.

适用于所有浏览器的数学JavaScript显示引擎。

不需要更多的设置就可以工作。

---

在GitHub Pages中的设置方法
---
1. 找到自己jekll的主题配置文件.
2. 例如我的texture主题,在_layout中可以配置各种页面的样式,其中每个配置文件都include了_include路径下的head.html文件,所以在header.html文件中更改\<head\>就可以更改每种页面的样式.
3. 在[MathJax](https://www.mathjax.org/)官网中,找到它的js脚本配置如下:
```javascript
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
```
4. 由于Mathjax源码设置在国外服务器,直接添加此代码会导致在国内打开网页速度变得巨慢,所以,我们可以使用国内托管的Mathjax源码服务器,或者在有服务器的条件下自己搭建镜像服务器.  
在这里找到了国内的一个托管服务器,[mathjax | BootCDN - Bootstrap 中文网开源项目免费 CDN 加速服务](https://www.bootcdn.cn/mathjax/)  
用此网站提供的地址替换掉上面代码的地址.
5. 此时,在markdown文件中是只支持单行公式的,出于方便考虑,我们需要添加$ 公式 $ 的行内公式,添加相关配置后最终代码如下.
```javascript
<script src="https://cdn.bootcss.com/mathjax/2.7.6/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript">
</script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
    tex2jax: {
    skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'],
    inlineMath: [['$','$']]
    }
   });
</script>
```
6. 将其复制到对应html文件中即可使用.