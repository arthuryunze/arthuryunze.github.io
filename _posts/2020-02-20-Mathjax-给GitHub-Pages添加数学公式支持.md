---
description: 给GitHub Pages添加数学公式支持(Mathjax)
categories: Github math
---
首先介绍一下Mathjax，Mathjax是一个开源js引擎，用于在浏览器中显示数学公式.

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
1. 找到自己jekll的主题配置文件，一般配置文件在本机主目录`~/gems/gems/对应的主题`路径下。(若使用remote_theme模式，可以到相应主题的GitHub主页copy相关文件。)
2. 例如本Blog使用的[thelehhman/texture](https://github.com/thelehhman/texture)主题，一般来说，_layout路径下可以配置各种页面的样式，可以看到其中每个配置文件都引入了_include路径下的head.html文件，为了我们在各种页面中都可以使用数学公式，可以在header.html文件中更改\<head\>就可以更改每种页面的样式.  
(如果希望只在部分页面使用Mathjax，可更改_layout路径下相应的文件。)
3. 在[MathJax](https://www.mathjax.org/)官网中，找到它的js脚本配置如下:
```javascript
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
```
4. 由于Mathjax源码设置在国外服务器，直接添加此代码会导致在国内打开网页速度变得巨慢，所以，我们可以使用国内托管的Mathjax源码服务器，或者在有服务器的条件下自己搭建镜像服务器.  
在这里找到了国内的一个托管服务器，[mathjax | BootCDN - Bootstrap 中文网开源项目免费 CDN 加速服务](https://www.bootcdn.cn/mathjax/)  
用此网站提供的地址替换掉上面代码的地址.
5. 此时，在markdown文件中是只支持单行公式的，出于方便考虑，我们需要添加$ 公式 $ 的行内公式，添加相关配置后*最终代码*如下.
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

Reference:
---
[thelehhman/texture: A configurable theme for simply beautiful blogs.](https://github.com/thelehhman/texture)  
[MathJax | Beautiful math in all browsers.](https://www.mathjax.org)  
[mathjax | BootCDN - Bootstrap 中文网开源项目免费 CDN 加速服务](https://www.bootcdn.cn/mathjax)
