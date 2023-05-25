//
//  SessionDelegate.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 25/05/23.
//

import WatchConnectivity

class SessionDelegate: NSObject, WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
