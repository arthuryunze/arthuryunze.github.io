# python生成器遇到loop域产生的问题

```
def triangles():
    L = [1]
    while True:
    #为什么要加[:]
        yield L[:]
        L.append(0)
        
if __name__ == '__main__':

    # [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
    n = 0
    results = []

    # 如果L不加[:]切片，会导致此for循环先运行完再进行yield，while true中的代码会先运行十次
    # 导致有10个0，这应该是对L的原地址上直接进行了修改，因此要加上[:]
    for t in triangles():
        results.append(t)
        n = n + 1
        if n == 10:
            break

    for t in results:
        print(t)
```

