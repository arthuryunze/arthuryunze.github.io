---
title: "Haskell-learn-一"
date: 2020-03-01T16:57:58+08:00
draft: false
---

---
categories: ProgramLanguage Haskell
description: Function program learning
---

Types and Typeclasses
===

ghci 交互式shell中，:t判断变量类型。

```haskell
:t 'a' 
'a' :: Char
```

:: is read as "has type of".

函数类型显式声明
---
一般来说，Haskell有类型推断系统，不需要我们显式声明。但是，我们定义函数时会使用显式声明的办法。  
除了编写非常短的函数之外，这通常被认为是一个好的实践。

This is generally considered to be good practice except when writing very short functions.

```haskell
addThree :: Int -> Int -> Int -> Int  
addThree x y z = x + y + z  
```

前三个Int是参数类型，最后一个是输出类型。
参数之间用->分隔，并且参数和返回类型之间没有特殊区别。


`product [1..10]` 120 1到10的乘积

head takes a list of any type and returns the first element  
`head [1..10]` 1 返回列表第一项  

Remember fst? It returns the first component of a pair.  
`fst (1,2)` 1 返回元组第一项  
```haskell
:t fst
fst :: (a, b) -> a
```




类型变量——Type variables
---

Functions that have type variables are called polymorphic functions.  
具有类型变量的函数称为多态函数

```haskell
:t fst
fst :: (a, b) -> a
```
a,b都不是基本类型，都是类型变量

基本类型开头字母都是大写。Char Num Fractional

```haskell
*Main> :t 'a'
'a' :: Char
*Main> :t 1
1 :: Num t => t
*Main> :t 1.1
1.1 :: Fractional t => t
```


类型类——Typeclasses
---
实现类似接口的功能

```haskell
:t (==)
(==) :: Eq a => a -> a -> Bool

:t (elem)
(elem) :: (Eq a, Foldable t) => a -> t a -> Bool
```

### 常见类型类

`Eq`被用来支持类做相等性测试。  
The functions its members implement are == and /=.  
它的成员都实现了==和/=（不等）

所有基本类型都在Eq内（除了IO相关和function）

`Ord` is for types that have an ordering.  Ord covers all the standard comparing functions such as >, <, >= and <=. 
有排序的类。

```haskell
ghci> :t (>)  
(>) :: (Ord a) => a -> a -> Bool  
```

函数compare 有三种返回值GT, LT or EQ, meaning greater than, lesser than and equal

```haskell
ghci> "Abrakadabra" < "Zebra"  
True  
ghci> "Abrakadabra" `compare` "Zebra"  
LT  
ghci> 5 >= 2  
True  
ghci> 5 `compare` 3  
GT  
```

