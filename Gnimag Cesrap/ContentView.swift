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
    var peerid:String = ""
    var sessionid: String = ""
    var body: some View {
        ParsecViewController(peerId: PEER_ID, sessionId: SESSION_ID)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
