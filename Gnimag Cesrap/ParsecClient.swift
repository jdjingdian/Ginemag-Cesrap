//
//  ParsecClient.swift
//  Gnimag Cesrap
//
//  Created by Derek Jing on 2021/11/6.
//

//Thanks for the help from Ztepsa, this part of the code is based on his code. His guidance is really. His guidance is very helpful to this project!

import Foundation
import ParsecSDK
import GLKit

//final class Parsec {
//    public var version = ParsecVersion()
//    private var parsec: OpaquePointer? = nil
////    private var audio: UnsafeMutablePointer<
//    private var config: ParsecConfig
//    init(clientPort: Int32 = 8000, hostPort: Int32 = 22681, upnp:Bool = true) {
//        self.config = ParsecConfig(upnp: upnp ? 1: 0, clientPort: clientPort, hostPort: hostPort)
//    }
//
//    private var logHandler: ParsecLogCallback = { (log,message, _) in
//        if let msg = message, let payload = String(validatingUTF8: msg) {
//            let prefix = log == LOG_DEBUG ? "[DEBUG]":"[INFO]"
//            let output = [prefix,": ",payload].joined()
//            print(output)
//        }
//    }
//
//    public func drawingHandler(_ view: GLKView, drawIn rect: CGRect ){
//        guard let client = parsec else {return}
////        ParsecClientPollAudio(<#T##ps: OpaquePointer!##OpaquePointer!#>, <#T##callback: ParsecAudioCallback!##ParsecAudioCallback!##(UnsafePointer<Int16>?, UInt32, UnsafeMutableRawPointer?) -> Void#>, <#T##timeout: UInt32##UInt32#>, <#T##opaque: UnsafeRawPointer!##UnsafeRawPointer!#>)
//        ParsecClientSetDimensions(parsec, UInt8(DEFAULT_STREAM), UInt32(view.frame.width), UInt32(view.frame.height), Float(UIScreen.main.scale))
//        ParsecClientGLRenderFrame(parsec, UInt8(DEFAULT_STREAM), nil, nil, 30)
//        glFinish() // May Improve latency
//    }
//
//    func setup() -> Bool {
//        let ps = ParsecInit(self.version, &self.config, nil, &self.parsec)
//        guard ps == PARSEC_OK else {return false}
//        ParsecSetLogCallback(self.logHandler, nil)
//        return true
//    }
//
//    func destory() {
//        ParsecSetLogCallback(nil, nil)
//        ParsecDestroy(parsec)
//        //RESERVED FOR AUDIO
//    }
//    deinit {
//        guard parsec != nil else { return }
//        destory()
//    }
//}
//
//extension Parsec {
//    func connect(to peerId: String, sessionId: String) -> Bool {
//        return peerId.withCString { peerIdPtr in
//            return sessionId.withCString { sessionIdPtr in
//                let ps = ParsecClientConnect(self.parsec, nil, sessionIdPtr, peerIdPtr)
//                return ps == PARSEC_OK
//            }
//        }
//    }
//}


final class Parsec {
    public var version = ((UInt32(PARSEC_VER_MAJOR) << 16) | UInt32(PARSEC_VER_MINOR))
    private var parsec: OpaquePointer? = nil
    //    private var audio: UnsafeMutablePointer<Paraudio>? = nil
    private var config: ParsecConfig
    
    public func drawingHandler(_ view: GLKView, drawIn rect: CGRect) {
        guard let client = parsec  else { return }
        //        ParsecClientPollAudio(client, audio_cb, 0, decoder)
        ParsecClientSetDimensions(self.parsec, UInt8(DEFAULT_STREAM), UInt32(view.frame.width), UInt32(view.frame.height), Float(UIScreen.main.scale))
        ParsecClientGLRenderFrame(self.parsec, UInt8(DEFAULT_STREAM), nil, nil, 30)
        //        glFinish() // May improve latency
        
    }
    
    private var logHandler: ParsecLogCallback = { (log, message, _) in
        if let msg = message, let payload = String(validatingUTF8: msg) {
            let prefix = log == LOG_DEBUG ? "[debug]" : "[info]"
            let output = [prefix, ": ", payload].joined()
            print(output)
        }
    }
    
    init(clientPort: Int32 = 8000, hostPort: Int32 = 9000, upnp: Bool = true) {
        self.config = ParsecConfig(upnp: upnp ? 1 : 0, clientPort: clientPort, hostPort: hostPort)
    }
    
    func setup() -> Bool {
        let ps = ParsecInit(self.version, nil, nil, &self.parsec)
        guard ps == PARSEC_OK else { return false }
//        audio_init(&self.audio)
//        guard self.audio != nil else { return false }
        ParsecSetLogCallback(self.logHandler, nil)
        return true
    }
    
    func destroy() {
        ParsecSetLogCallback(nil, nil)
        ParsecDestroy(parsec)
//        audio_destroy(&audio)
    }
    
    deinit {
        guard parsec != nil else { return }
        destroy()
    }
}

extension Parsec {
    func connect(to peerId: String, sessionId: String) -> Bool {
        return peerId.withCString { peerIdPtr in
            return sessionId.withCString { sessionIdPtr in
                let ps = ParsecClientConnect(self.parsec,
                                             nil,
                                             UnsafeMutablePointer(mutating: sessionIdPtr),
                                             UnsafeMutablePointer(mutating: peerIdPtr))
                return ps == PARSEC_OK
            }
        }
    }
}
