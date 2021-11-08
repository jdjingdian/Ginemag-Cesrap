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
let  count = 0
final class Parsec {
    public var version = ParsecVersion()
    private var parsec: OpaquePointer? = nil
//    private var audio: UnsafeMutablePointer<
    private var config: ParsecConfig
    init(clientPort: Int32 = 8000, hostPort: Int32 = 22681, upnp:Bool = true) {
        self.config = ParsecConfig(upnp: upnp ? 1: 0, clientPort: clientPort, hostPort: hostPort)
    }

    private var logHandler: ParsecLogCallback = { (log,message, _) in
        if let msg = message, let payload = String(validatingUTF8: msg) {
            let prefix = log == LOG_DEBUG ? "[DEBUG]":"[INFO]"
            let output = [prefix,": ",payload].joined()
            print(output)
        }
    }

    public func drawingHandler(_ view: GLKView, drawIn rect: CGRect ){
        guard let client = parsec else {return}
        
//        ParsecClientSetConfig(client, PARSEC_CLIENT_DEFAULTS)
        ParsecClientSetDimensions(parsec, UInt8(DEFAULT_STREAM), UInt32(view.frame.width), UInt32(view.frame.height), Float(UIScreen.main.scale))
        ParsecClientGLRenderFrame(parsec, UInt8(DEFAULT_STREAM), nil, nil, 30)
        glFinish() // May Improve latency
    }

    func setup() -> Bool {
        let ps = ParsecInit(self.version, &self.config, nil, &self.parsec)
        guard ps == PARSEC_OK else {return false}
        ParsecSetLogCallback(self.logHandler, nil)
        return true
    }

    func destory() {
        ParsecSetLogCallback(nil, nil)
        ParsecDestroy(parsec)
        //RESERVED FOR AUDIO
    }
    deinit {
        guard parsec != nil else { return }
        destory()
    }
}

extension Parsec {
    func connect(to peerId: String, sessionId: String) -> Bool {
       
        return peerId.withCString { peerIdPtr in
            return sessionId.withCString { sessionIdPtr in
                //decoderIndex为0时，使用软件解码，设置为1则使用硬件解码
                var videoCfg = ParsecClientVideoConfig(decoderIndex: 1, resolutionX: 1920, resolutionY: 1080, decoderCompatibility: false, decoderH265: true, decoder444: false, __pad: (0))
                let secert = (Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0),Int8(0))
                
                var clientCfg = ParsecClientConfig(video: (videoCfg,videoCfg), mediaContainer: 0, protocol: 1, secret: secert, pngCursor: false, __pad: (0,0,0))
                
                
                let ps = ParsecClientConnect(self.parsec, &clientCfg, sessionIdPtr, peerIdPtr)
                return ps == PARSEC_OK
            }
        }
    }
    
    func keyboardMsg(keycode: UInt32,pressed:Bool){
        var msg = ParsecMessage()
        msg.type = MESSAGE_KEYBOARD
        if keycode == 227 {
            msg.keyboard.code.rawValue = 227
        }else{
            msg.keyboard.code.rawValue = keycode
        }
        //
        msg.keyboard.mod.rawValue = 0x0000
        msg.keyboard.pressed = pressed
        ParsecClientSendMessage(self.parsec, &msg)
    }
}


