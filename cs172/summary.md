# Chapter 7

## File Handling

```python
@property
@setter
def __iter__(self):
```

### pickle module

1.  We must use write binary mode _wb_ when pickling data in binary format
2.  To write compressed data, we use gzip.open() to open the file

```python
fh = gzip.open(filename, "wb")
```

In Python 3.0 and 3.1, pickle.HIGHEST_PROTOCOL is protocol 3,in Python 3.4 is protocol 4, and Python 3.8 is protocol 5

```python
pickle.dump(self, fh, pickle.HIGHEST_PROTOCOL)
```

```python
pickle.dump(obj, file, protocol=None, *, fix_imports=True, buffer_callback=None)¶
#将对象 obj 封存以后的对象写入已打开的 file object file。

pickle.dumps(obj, protocol=None, *, fix_imports=True, buffer_callback=None)
#将 obj 封存以后的对象作为 bytes 类型直接返回，而不是将其写入到文件。

pickle.load(file, *, fix_imports=True, encoding='ASCII', errors='strict', buffers=None)
#从已打开的 file object 文件 中读取封存后的对象，重建其中特定对象的层次结构并返回。

pickle.loads(data, /, *, fix_imports=True, encoding='ASCII', errors='strict', buffers=None)
#重建并返回一个对象的封存表示形式 data 的对象层级结构。 data 必须为 bytes-like object。
```

#### Pickles with Optional Compression

- To read back the data, we need to distinguish between a compressed
  and an uncompressed pickle
- Any file that is compressed by gzip begins with a magic number
  - a magic number is a sequence of one or more bytes
  - it’s located at the beginning of a file, used to indicate the file’s type
- For gzip files the magic number is the two bytes 0x1F 0x8B
  I which we store in a bytes variable: b"\x1F\x8B

```python
GZIP_MAGIC = b"\x1F\x8B"
#gzip 的默认标识
fh = open(filename, "rb")
magic = fh.read(len(GZIP_MAGIC))
if magic == GZIP_MAGIC:
    fh.close()
    fh = gzip.open(filename, "rb")
else:
    fh.seek(0)
```

```python
#只要这样就能用gzip压缩
if compress:
    fh = gzip.open(filename, "wb")
pickle.dump(self, fh, pickle.HIGHEST_PROTOCOL)

```

### Writing Text

#### Text wrappe

```python
textwrap.dedent(text)
#去除相同字符的前缀
wrapper = textwrap.TextWrapper(initial_indent,subsequent_indent)
wrapper.wrap(text, width=70, *, initial_indent='', subsequent_indent='')
#为字符添加相同前缀并形成列表
```

<https://docs.python.org/zh-cn/3/library/textwrap.html?highlight=text%20wrapper#textwrap.TextWrapper>

# Chapter 8

## Functional-Style Programming

Three concepts are strongly associated with functional programming

- mapping
- filtering
- reducing

```python
import functools
print(list(filter(lambda x:x%2==0,[i for i in range(5)])))
print(list(map(lambda x:x**2,[i for i in range(5)])))
print(functools.reduce(lambda x, y: x*y, [i for i in range(1,5)]))
print(all([1, 'a', True]))
print(any([1, '', True]))
```

os.path.getsize

# Chapter 9

Test Driven Development (TDD)

## Finding and Fixing the bug

```python
print(locals(), "\n")
```

locals() returns a dictionary whose keys are the names of the local variables and whose values are the variables’ values

### pdb

```python
import pdb
pdb.set_trace()
```

commands are written after the (Pdb) prompt

- s means step, i.e., execute the statement shown
- p means print, we have used it, e.g., to show the value of numbers

```python
(Pdb) p numbers
[1,2,3]
```

- c means continue to the end of the program

### doctest

```python
#这样启动doctest
import doctest
doctest.testmod()
```

或者

```shell
python -m doctest _program.py_
```

### Few Python habits good for performance:

1. Prefer tuples over lists when a read-only sequence is needed
2. Use generators rather than creating large tuples or lists to iterate over
3. Use Python’s built-in data structures rather than custom data structures
4. When creating large strings out of small strings, instead of
   concatenating the small strings,
   accumulate them in a list, and join them only once
5. If an object is accessed many times, or from a data structure,
   I it may be better to use a local variable that refers to the object
   I this provides faster access

### Profiling

#### timeit

```python
def func(x): pass
import timeit
x = 1
#第一个字符是要执行的语句
#第二个字符是从主进程中引入变量
t = timeit.Timer('func(x)','from __main__ import x,func')
print(t.timeit(10))
```

# Chapter 10

## multiprocess

### parent

```python
import subprocess

#输入命令可以是字符串也可以是列表
command = "python _program.py_"
#若要从外部读取或输入数据必须指定stdin和stdout
s = subprocess.Popen(command,stdin=subprocess.PIPE,stdout=subprocess.PIPE)

s.stdin.write('hello')
#记得关闭
s.stdin.close()

#与子进程交流，获取执行输出
s.communicate()
#若指定了stdout则该函数会返回(output,err)
#此时所有输出都会存入output中
out,_ = pipe.communicate()
```

### child

```python
import sys
#若要在子进程中读取数据则可以这样读取
stdin = sys.stdin.buffer.read()
words = stdin.decode('utf-8')
```

## multithread

There are two ways to create threads:

1. calling threading.Thread() and pass it a callable object

```python
import threading
for i in range(5):
    t = threading.Thread(target=print,args=[i,i+1])
    t.start()
```

2. subclassing the threading.Thread class

```python
import threading
class MyThread(threading.Thread):
  def __init__():
    super().__init__
    pass
  #必须要实现run函数
  def run():
    pass
t = MyThread()
t.start()
#阻塞调用该函数的主线程直到被调用的线程运行结束
t.join()
```

### Queue

- This class is special since it handles all the locking itself internally
- Whenever we access it to add or remove items, we can rely on the
  queue itself to serialize accesses
- In the context of threading, serializing access to data means ensuring that only one thread at a time has access to the data

```python
import queue
q = queue.Queue()

#在Thread子类中的run函数
def run():
  item = q.get()
  #此处对元素做某些处理
  q.task_done()#完成任务释放锁

#初始化队列
for i in range(10):
  q.put(i)
#注意在队列中还没有元素时线程中获取数据的尝试会被block
#一旦队列中加入元素线程将能够正常运作

#join会阻塞主线程直到所有任务完成
q.join()
```

### daemon

守护线程
当 daemon 设置 True 时，该线程会随主线程退出而结束。
当 daemon 设置 False 时，主线程会等待该线程结束后才退出；

```python
#自定义类中必须定义daemon才可以作为参数使用
t = threading.Thread(target=_func_,args=*args,daemon=True)
#daemon可以在外部设置
t.daemon = True
```

# Chapter 11

## networking protocols

- user datagram protocol (UDP), lightweight but unreliable; data is sent
  as discrete packets but with no guarantee that they will arrive
- transmission control protocol (TCP), reliable connection- and
  stream-oriented protocol; any amount of data can be sent

## Creat TCP server

### client

1. 定义 socketmanager

```python
import socket

class SocketManager:
  def __init__(self,addr):
    self.addr = addr
  def __enter__(self):
    self.conn = socket.socket()
    self.conn.connect(self.addr)
    return self.conn
  def __exit__(self,*args):
    self.conn.close()
```

2. 定义数据编码

```python
import struct
struc = struct.Struct('!I')
data = pickle.dumps(items)
size = struc.pack(len(data))
```

3. 与服务器交互

```python
with SocketManager(addr) as sock:
  #向服务器发送数据
  sock.sendall(size)
  sock.sendall(data)

  #接受来自服务器的数据
  recv = bytearray()#创建一个二进制数组

  size = sock.recv(struc.size)
  size = struc.unpack(size)[0]#注意解包后是数组

  #接受并处理数据
  while len(recv) < size:
    data = sock.recv(4096)
    recv.extend(data)
  result = pickle.loads(recv)
```

4. 错误处理

```python
except socket.error as e:
  sys.exit(1)
```

### server

1. 创建服务器类和请求处理类

```python
import socketserver
import struct
#需要记住这两个参数
class MyServer(socketserver.ThreadingMiXin,socketserver.TCPServer): pass

class MyHandler(socketserver.StreamRequestHandler):
  #需要自定义handle函数
  def handle(self):
    #读取数据
    SizeStruct = struct.Struct("!I")
    size_data = self.rfile.read(SizeStruct.size)
    size = SizeStruct.unpack(size_data)[0]
    data = pickle.loads(self.rfile.read(size))

    #在这里做一些数据处理
    reply = ...

    #返回数据
    data = pickle.dumps(reply, 3)
    self.wfile.write(SizeStruct.pack(len(data)))
    self.wfile.write(data)

  def close(self):]
    #停止服务器
    self.server.shutdown()
```

2. 调用启动服务器

```python
#需传入两个参数
server = MyServer(addr,MyHandler)
server.server_forever()
```

# Chapter 12

## Database Manager

Another kind is Database Manager (DBM)

- store any number of key-value items;
- DBMs work just like Python dictionaries, except

  - they are normally held on disk rather than in memory
  - their keys and values are always bytes objects
    The shelve module provides a convenient DBM interface
  - that allows us to use string keys and any (pickable) objects as values

- shelve.open()
  - opens a persistent dictionary producing a Shelf object
- shelve.Shelf.sync()
  - empties the cache, and
  - synchronizes the persistent dictionary on disk;
  - is called automatically when the shelf is closed with close()
- shelve.Shelf.close()
  - synchronizes and closes the persistent dict object

```python
import shelve
db = shelve.open(_file_,)
db['name'] = 1
db.sync()

del db['name']
db.sync()

db.close()
```

## sqlite3

### 创建表

```python
import sqlite3
db = sqlite3.connect(_file_)
if not os.path.exists(_file_):
  cursor = db.cursor()
  cursor.execute(
    'CREATE TABLE _name_ ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
    'name TEXT NOT NULL)'
  )
  db.commit()
```

### 插入

```python
cursor = db.cursor()
sql = 'INSERT INTO _name_ (name) VALUES (?)'
cursor.execute(sql,(name))
db.commit()
```

### 查询

```python
cursor = db.cursor()
sql = 'SELECT COUNT(*) FROM _name_'
cursor.execute(sql,(name))
count = cursor.fetchone()[0]
#或者多项数据：
count = cursor.fetchall()
```

### 更新

```python
cursor = db.cursor()
name = 1
sql = f'UPDATE _name_ SET name={name} WHERE id=1'
cursor.execute(sql)
db.commit()
```

# Chapter 13

基础连招：

```python
import re
match = re.match('_regex_','string')
match.group(0) #获取所有结果
```

[<u>re 文档链接</u>](https://docs.python.org/zh-cn/3/library/re.html?highlight=re#module-re)

```python
re.match(pattern, string, flags=0)
```

如果 string 开头的零个或多个字符与正则表达式 pattern 匹配，则返回相应的 Match。

```python
m = re.match(r"(..)+", "a1b2c3")  # Matches 3 times.
m.group(1)                        # Returns only the last match.
```

如果一个组匹配成功多次，就只返回最后一个匹配

```python
re.search(pattern, string, flags=0)
```

扫描整个 string 查找正则表达式 pattern 产生匹配的第一个位置，并返回相应的 Match。
