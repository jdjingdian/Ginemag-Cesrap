////
////  ParsecMTKView.swift
////  Gnimag Cesrap
////
////  Created by Derek Jing on 2021/11/7.
////
//
//import Foundation
//import ParsecSDK
//import Metal
//import MetalKit
//import Combine
//import SwiftUI
//
//final class ParsecMTK: UIViewController {
//    public let version = ParsecVersion()
//    private let parsec: Parsec_re
//    private let peerId: String
//    private let sessionId: String
//    private var metalView: MTKView!
//    private var metalDevice: MTLDevice!
//    private var metalCommandQueue: MTLCommandQueue!
////    private var parsec: OpaquePointer? = nil
////    private var config: ParsecConfig
//
////    private lazy var commandQueue = self.device?.makeCommandQueue()
////    private lazy var context: CIContext = {
////        guard let device = self.device else {
////            assertionFailure("The PreviewUIView should have a Metal device")
////            return CIContext()
////        }
////        return CIContext(mtlDevice: device)
////    }()
//
//
//    init(parsec: Parsec_re = Parsec_re(),peerId: String, sessionId: String){
//        self.parsec = parsec
//        self.peerId = peerId
//        self.sessionId = sessionId
//        self.metalDevice = MTLCreateSystemDefaultDevice()
//        self.metalCommandQueue = metalDevice.makeCommandQueue()
//        self.metalView.device = metalDevice
////        self.metalView.delegate = self
//        print("Parsec initialized.")
//        
//        
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    //    init(clientPort: Int32 = 8000, hostPort: Int32 = 22681, upnp:Bool = true) {
////        self.config = ParsecConfig(upnp: upnp ? 1: 0, clientPort: clientPort, hostPort: hostPort)
////    }
//
//}
//
////extension Parsec {
////    func connect(to peerId: String, sessionId: String) -> Bool {
////        return peerId.withCString { peerIdPtr in
////            return sessionId.withCString { sessionIdPtr in
////                let ps = ParsecClientConnect(self.parsec, nil, sessionIdPtr, peerIdPtr)
////                return ps == PARSEC_OK
////            }
////        }
////    }
////}
//
//
