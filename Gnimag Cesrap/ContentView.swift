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
    private let rotationChangePublisher = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
    var peerid:String = ""
    var sessionid: String = ""
    let parsecClient = Parsec()
    var body: some View {
        ZStack(){
            
            ParsecViewController(parsec: parsecClient, peerId: PEER_ID, sessionId: SESSION_ID)
            Text("Exit")
                .foregroundColor(.red)
        }.edgesIgnoringSafeArea(.all)
//        .onAppear {
//            changeOrientation(to: .landscapeRight)
//        }
        
    }

    func changeOrientation(to orientation: UIInterfaceOrientation) {
            // tell the app to change the orientation
            UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
            print("Changing to", orientation.isPortrait ? "Portrait" : "Landscape")
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
