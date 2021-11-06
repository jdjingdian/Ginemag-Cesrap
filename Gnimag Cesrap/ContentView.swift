//
//  ContentView.swift
//  Ginemag Cesrap
//
//  Created by Derek Jing on 2021/11/3.
//

import SwiftUI
import ParsecSDK
import OpenGLES

struct ContentView: View {
    var parsec = UnsafeMutablePointer<OpaquePointer?>.allocate(capacity: 1)
    @State var status: ParsecStatus = ParsecStatus.init(rawValue: -1)
    var body: some View {
        VStack(){
            Text("Hello, world!")
                .padding()
        }.onAppear {
            print("PasecState: \(status)")
            print(ParsecSDK.ParsecVersion())
            status = ParsecSDK.ParsecInit(ParsecSDK.ParsecVersion(), nil, nil,parsec)
            print("PasecState: \(status)")
            if status != PARSEC_OK {
                print("Parsec init failed: \(status)")
            }
            
            ParsecSDK.ParsecClientConnect(parsec.pointee, nil, SESSION_ID, PEER_ID)
            if status != PARSEC_OK {
                print("Parsec Client Connect failed: \(status)")
                
            }else{
                DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()+5, execute: {
                    while true {
//                        ParsecClientSetD
                        status = ParsecClientGLRenderFrame(parsec.pointee, UInt8(DEFAULT_STREAM), nil, nil, 10)
                        print("while Status:\(status)")
                        
                        
                        
                    }
                })
            }
            
            
            
//            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()+10, execute: {
//                ParsecSDK.ParsecDestroy(parsec.pointee)
//                print("PasecState: \(status)")
//            })
            print("parsec:\(parsec)")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
