//
//  ParsecMTKView.swift
//  Gnimag Cesrap
//
//  Created by Derek Jing on 2021/11/7.
//

import Foundation
import ParsecSDK
import Metal
import MetalKit

import Combine
import SwiftUI

//final class ParsecMTK: MTKView {
//    public var version = ParsecVersion()
//    private var parsec: OpaquePointer? = nil
//    private var config: ParsecConfig
//
//    private lazy var commandQueue = self.device?.makeCommandQueue()
//    private lazy var context: CIContext = {
//        guard let device = self.device else {
//            assertionFailure("The PreviewUIView should have a Metal device")
//            return CIContext()
//        }
//        return CIContext(mtlDevice: device)
//    }()
//
//
//
//    init(clientPort: Int32 = 8000, hostPort: Int32 = 22681, upnp:Bool = true) {
//        self.config = ParsecConfig(upnp: upnp ? 1: 0, clientPort: clientPort, hostPort: hostPort)
//    }
//
//    init(device: MTLDevice?, imagePublisher: AnyPublisher<CIImage?, Never>) {
//        super.init(frame: .zero, device: device)
//
//        // setup view to only draw when we need it (i.e., a new pixel buffer arrived),
//        // not continuously
//        self.isPaused = true
//        self.enableSetNeedsDisplay = true
//        self.autoResizeDrawable = true
//
//        #if os(iOS)
//        // we only need a wider gamut pixel format if the display supports it
//        self.colorPixelFormat = (self.traitCollection.displayGamut == .P3) ? .bgr10_xr_srgb : .bgra8Unorm_srgb
//        #endif
        // this is important, otherwise Core Image could not render into the
        // view's framebuffer directly
//        self.framebufferOnly = false
//        self.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)

        // try to display an image as soon as it is published
//        imagePublisher.bind(to: self) { me, image in
//            me.imageToDisplay = image
//            #if os(iOS)
//            me.setNeedsDisplay()
//            #elseif os(OSX)
//            me.needsDisplay = true
//            #endif
//        }
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private var logHandler: ParsecLogCallback = { (log,message, _) in
//        if let msg = message, let payload = String(validatingUTF8: msg) {
//            let prefix = log == LOG_DEBUG ? "[DEBUG]":"[INFO]"
//            let output = [prefix,": ",payload].joined()
//            print(output)
//        }
//    }

//    public func drawingHandler(_ view: MTKView, drawIn rect: CGRect ){
//        guard let client = parsec else {return}
//        ParsecClientPollAudio(<#T##ps: OpaquePointer!##OpaquePointer!#>, <#T##callback: ParsecAudioCallback!##ParsecAudioCallback!##(UnsafePointer<Int16>?, UInt32, UnsafeMutableRawPointer?) -> Void#>, <#T##timeout: UInt32##UInt32#>, <#T##opaque: UnsafeRawPointer!##UnsafeRawPointer!#>)
//        ParsecClientSetDimensions(client, UInt8(DEFAULT_STREAM), UInt32(view.frame.width), UInt32(view.frame.height), Float(UIScreen.main.scale))
//        ParsecClientGLRenderFrame(client, UInt8(DEFAULT_STREAM), nil, nil, 30)

        
//    }
    
//    override func draw(_ rect: CGRect) {
        
//        guard let client = parsec else {return}
//        guard let input = ParsecClientMetalRenderFrame(client, UInt8(DEFAULT_STREAM), &commandQueue, nil, nil, nil, 10)
//        ParsecMetal
//        guard let input = self.imageToDisplay,
//              let currentDrawable = self.currentDrawable,
//              let commandBuffer = self.commandQueue?.makeCommandBuffer() else { return }

        // scale to fit into view
//        let drawableSize = self.drawableSize
//        let scaleX = drawableSize.width / input.extent.width
//        let scaleY = drawableSize.height / input.extent.height
//        let scale = min(scaleX, scaleY)
//        let scaledImage = input.transformed(by: CGAffineTransform(scaleX: scale, y: scale))

        // center in the view
//        let originX = max(drawableSize.width - scaledImage.extent.size.width, 0) / 2
//        let originY = max(drawableSize.height - scaledImage.extent.size.height, 0) / 2
//        let centeredImage = scaledImage.transformed(by: CGAffineTransform(translationX: originX, y: originY))

        // Create a render destination that allows to lazily fetch the target texture
        // which allows the encoder to process all CI commands _before_ the texture is actually available.
        // This gives a nice speed boost because the CPU doesn't need to wait for the GPU to finish
        // before starting to encode the next frame.
        // Also note that we don't pass a command buffer here, because according to Apple:
        // "Rendering to a CIRenderDestination initialized with a commandBuffer requires encoding all
        // the commands to render an image into the specified buffer. This may impact system responsiveness
        // and may result in higher memory usage if the image requires many passes to render."
//        let destination = CIRenderDestination(width: Int(drawableSize.width),
//                                              height: Int(drawableSize.height),
//                                              pixelFormat: self.colorPixelFormat,
//                                              commandBuffer: nil,
//                                              mtlTextureProvider: { () -> MTLTexture in
//                                                return currentDrawable.texture
//        })
//
//        do {
//            try self.context.startTask(toClear: destination)
//            try self.context.startTask(toRender: centeredImage, to: destination)
//        } catch {
//            assertionFailure("Failed to render to preview view: \(error)")
//        }
//
//        commandBuffer.present(currentDrawable)
//        commandBuffer.commit()
//    }
//
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


