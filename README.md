# Swift集成Parsec SDK方法记录

## 项目介绍

GNIMAG CESRAP是PARSEC GAMING的第三方客户端，使用Swift + SwiftUI编写，因为官方一直不释放iOS版本，所以有了这个项目。

## 获取Session ID

> 参考官方获取sessionID方式，我是用curl命令获取的，蛮方便的
>
> https://github.com/parsec-cloud/parsec-sdk/tree/master/api/personal

## Parsec SDK运行流程

1. `ParsecSetLogCallback`从SDK读取Log，获取DEBUG信息

2. `ParsecInit`方法激活Parsec客户端实例

   ``` swift
   ParsecSDK.ParsecInit(ParsecSDK.ParsecVersion(), nil, nil,parsec)
   //其中parsec是一个指针，类型是：UnsafeMutablePointer<OpaquePointer?>
   //前面三个为输入参数，分别是Parsec版本、自定义配置信息和未来预留，第四个为输出信息，也就是创建好的Parsec实例
   var parsec = UnsafeMutablePointer<OpaquePointer?>.allocate(capacity: 1) //大概率还要修改
   ```

3. `ParsecClientConnect(_ ps: OpaquePointer!, _ cfg: UnsafePointer<ParsecClientConfig>!, _ sessionID: UnsafePointer<CChar>!, _ peerID: UnsafePointer<CChar>!) -> ParsecStatus)`创建点对点连接

   ``` swift
   ParsecSDK.ParsecClientConnect(parsec.pointee, nil, SESSION_ID, PEER_ID)
   //SESSION_ID可以通过CURL命令取得，相当于你登录的标识符，PEER_ID是要连接的设备的ID
   //第一个参数要求输入parsec实例，但类型是OpaquePointer?，所以通过pointee方法输出OpaquePointer类型
   
   ```
   
4. `ParsecSDK.ParsecDestroy(_ ps: OpaquePointer?)`
   传入参数也是`OpaquePointer?`，使用该方法似乎会卡死界面，所以要在DispatchQueue.global()队列中使用为佳

   

## 感谢

非常感谢[@Zoran Tepša](https://github.com/ztepsa])在issue中耐心解答我的问题，起初我对如何把sdk中渲染的画面通过opengl渲染出来感到非常困惑，如果没有他的帮助，我可能会很久很久都不知道要怎么办。
