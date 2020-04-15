# dio_ext

基于Dio的功能扩展，比如拦截器、简易客户端等。

### 配置    
```
//在工程的yaml文件中添加一下依赖
dependencies:
    dio_interceptors: ^0.0.1
```
### 使用

#### 拦截器（Interceptors）

##### 日志拦截器
`dio.interceptors.add(new DioLogInterceptor());`
在自己的dio实例中配置以上语句即可使用。
类似原生Android开发中使用`okhttp3`的`logging-interceptor`.

下面是请求http://www.baidu.com输出的日志效果：
```
Http: --> GET https://www.baidu.com/wd=sdsdf
Http: Headers:{content-type: application/json; charset=utf-8}
Http: --> END GET
Http: <-- 200 OK https://www.baidu.com/wd=sdsdf (649ms)
Http:{the response：Omitted because there is too much content}
Http: <-- END HTTP
```
以下是对标记的完整说明：
其中Http是日志标签,默认为Http，如果需要修改，创建DioLogInterceptor时指定参数即可。
-->：表示发起请求。
GET：请求方式
Header：请求的Header内容。
END GET：请求日志输出完成的标志。

<--:表示相应 
200： 是请求的响应码，即http status code。
OK：是本次请求结果的一个文本描述 
(649ms)：括号中是计算的请求响应时间。
{the response：Omitted because there is too much content}：响应的body内容，由于内容太多，示例中没有输出具体内容
<-- END HTTP： 响应日志输出完成的标志。

