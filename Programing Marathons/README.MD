“This is part of the code I write during programming marathons. Most of it consists of input and output, so there isn’t much to see here. The important part is the process of solving the big problem. Most of the results are the test cases to see if it works correctly or not.”

```python
n = int(input())
k = n//3
r = n%3
rk = k%3
if rk == 1:
    if r == 1:
        print(k, k, k+1)
    elif r == 2:
        print(k, k+1,k+1)
    else:
        print(k,k,k)
elif rk == 2:
    if r == 1:
        print(k-1, k, k+2)
    elif r == 2:
        print(k, k, k+2)
    else:
        print(k, k, k)
else:
    if r == 1:
        print(k+1, k-1, k+1)
    elif r == 2:
        print(k+2, k-1, k+1)
    else:
        print(k+1, k-2, k+1)

```

    77 77 79
    


```python
nm = [int(i) for i in input().split()]
if nm[1] == 1:
    print(nm[0] - 1)
else:
    print(nm[0]*(nm[1]-1))
```

    8
    


```python
for i in range(int(input())):
    m = int(input())
    d = m//2020
    r = m%2020
    if r>d:
        print('NO')
    else:
        print('YES')
```

    NO
    YES
    YES
    YES
    NO
    


```python
for i in range(int(input())):
    f = [int(i) for i in input().split()]
    while f[0] > 20 and f[1] != 0:
        f[0] = f[0]//2 + 10
        f[1] -= 1
    f[0] = f[0] - f[2]*10
    if f[0] <= 0:
        print('YES')
    else:
        print('NO')

```

    YES
    NO
    NO
    YES
    YES
    YES
    YES
    


```python
for i in range(int(input())):
    f = [int(i) for i in input().split()]
    print(1,1,f[0],f[1]) 
```

    1 1 2 3
    1 1 4 4
    1 1 3 5
    


    ---------------------------------------------------------------------------

    IndexError                                Traceback (most recent call last)

    Cell In[35], line 3
          1 for i in range(int(input())):
          2     f = [int(i) for i in input().split()]
    ----> 3     print(1,1,f[0],f[1]) 
    

    IndexError: list index out of range



```python
f = [int(i) for i in input().split()]
if f[2] < f[0]:
    print('NO')
elif f[2] == f[0]:
    print('YES')
elif f[2] > f[0] and f[2] < (f[1] + f[0]):
    print('NO')
elif int((f[2]-f[0])/f[1]) == (f[2]-f[0])/f[1]:
    print('YES')
elif int((f[2]-f[0]-1)/f[1]) == (f[2]-f[0]-1)/f[1]:
    print('YES')
else:
    print('NO')

```


    ---------------------------------------------------------------------------

    IndexError                                Traceback (most recent call last)

    Cell In[20], line 2
          1 f = [int(i) for i in input().split()]
    ----> 2 if f[2] < f[0]:
          3     print('NO')
          4 elif f[2] == f[0]:
    

    IndexError: list index out of range



```python
n = int(input())
a = -1/2 + (2*(2*n)**(1/2))/2
a = int(a)
k = (a/2)*(a+1)
if k == n:
    print(int(k))
else:
    n = n-k
    print(int(n))
```

    10.083005244258363
    1
    


```python
f = [int(i) for i in input().split()]
g = [int(i) for i in input().split()]
s =(g[0]*f[1])/f[2]
sm = sum(g)
if s < sm:
    g2 = g[1:]
    g2.sort(reverse=True)
    i = 0
    while s < sm:
        sm -= g2[i]
        i += 1
    print(i)
else:
    print(0)
```

    4
    


```python
n = str(input())
if '0' in n:
    print(n.replace('0','',1))
else:
    print(n[1:])
```

    11010
    


```python
for i in range(int(input())):
    n = [int(i) for i in input().split()]
    m = [int(i) for i in input().split()]
    if m[2] == m[4] and (n[0]>0 or n[1]>0):
        print('No')
    elif m[3] == m[5] and (n[2]>0 or n[3]>0):
        print('No')
    else:
        n = [m[0] + n[1] - n[0],m[1] + n[3] - n[2]]
        if (m[2] > n[0]) or (n[0] > m[4]):
            print('No')
        elif (m[3] > n[1]) or (n[1] > m[5]):
            print('No')
        else:
            print('Yes')


```

    Yes
    No
    No
    Yes
    Yes
    Yes
    


```python
for i in range(int(input())):
    n = [int(i) for i in input().split()]
    k = 0
    n[1] = bin(n[1])[2:]
    for i,j in enumerate(range(len(n[1])-1,-1,-1)):
        if int(n[1][i]) == 1:
            k += int(n[0])**j
    print(k%1000000007)
```


```python
n = [int(i) for i in input().split()]
f = set()
r = set()
for i in range(n[1]):
    m = [int(i) for i in input().split()]
    f.add(m[0])
    r.add(m[1])
    print(str((n[0]-len(f))*(n[0]-len(r))), end= ' ')
```

    4 2 0 


```python
f = set()
f.add(1)
f.add(2)
```


```python
len(f)
```




    2




```python
4 2 0 

```

