//
//  ParsecView.swift
//  Gnimag Cesrap
//
//  Created by Derek Jing on 2021/11/6.
//

//Thanks for the help from Ztepsa, this part of the code is based on his code. His guidance is really. His guidance is very helpful to this project!

import Foundation
import SwiftUI
import OpenGLES
import GLKit
import ParsecSDK

extension ParsecViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ParsecViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<ParsecViewController>) -> ParsecViewController {
        return ParsecViewController(peerId: peerId, sessionId: sessionId)
    }
    
    func updateUIViewController(_ uiViewController: ParsecViewController, context: UIViewControllerRepresentableContext<ParsecViewController>) {
        
    }
}

final class ParsecViewController: UIViewController {
    private let parsec: Parsec
    private let peerId: String
    private let sessionId: String
    
    private let glView: GLKView
    private let glContext: EAGLContext
    private let glController: GLKViewController
    
    init(parsec: Parsec = Parsec(), peerId: String, sessionId: String) {
        self.parsec = parsec
        self.peerId = peerId
        self.sessionId = sessionId
        let context = EAGLContext(api: .openGLES3)!
        let view = GLKView(frame: UIScreen.main.bounds, context: context)
    
        let controller = GLKViewController()
        controller.view = view
        controller.preferredFramesPerSecond = 60
        self.glContext = context
        self.glView = view
        self.glController = controller
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .red
        view.delegate = self
        controller.delegate = self
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        print("Parsec initialized.")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressesBegan(_ presses: Set<UIPress>,
                               with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        for press in presses {
            print("key: \(String(describing: press.key?.characters))")
            parsec.keyboardMsg(keycode: UInt32(press.key?.keyCode.rawValue ?? 0), pressed: true)
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>,
                                   with event: UIPressesEvent?) {
            super.pressesEnded(presses, with: event)
        for press in presses {
            print("key: \(String(describing: press.key?.characters))")
            parsec.keyboardMsg(keycode: UInt32(press.key?.keyCode.rawValue ?? 0), pressed: false)
        }
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Parsec setup...")
        guard parsec.setup() else { fatalError("Could not perform setup") }
        print("Parsec connecting...")
        guard parsec.connect(to: peerId, sessionId: sessionId) else { fatalError("Could not connect") }
        print("Parsec connected.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        parsec.destory()
        print("Parsec destroyed.")
    }
    
    deinit {
        print("Parsec deinitialized.")
    }
}

extension ParsecViewController: GLKViewControllerDelegate {
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        //    print("glkViewControllerUpdate: \(controller)")
    }
}

extension ParsecViewController: GLKViewDelegate {
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        parsec.drawingHandler(view, drawIn: rect)
    }
}
