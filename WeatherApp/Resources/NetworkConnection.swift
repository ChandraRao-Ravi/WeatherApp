//
//  NetworkConnection.swift
//  WeatherApp
//
//  Created by Chandra Rao on 15/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import Foundation
import Reachability

class NetworkConnection {
    static let sharedInstance = NetworkConnection()
    
    var reachability: Reachability?
    let hostNames = ["google.com"]
    var hostIndex = 0
    var isConnectedToInternet: Bool = false
    
    private init() {
    }
    
    func startHost(at index: Int) {
        stopNotifier()
        setupReachability(hostNames[index], useClosures: false)
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.startHost(at: 0)
        }
    }
    
    func setupReachability(_ hostName: String?, useClosures: Bool) {
        let reachability: Reachability?
        if let hostName = hostName {
            reachability = try? Reachability(hostname: hostName)
        } else {
            reachability = try? Reachability()
        }
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
            }
            reachability?.whenUnreachable = { reachability in
            }
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
        }
    }
    
    func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .none {
            self.isConnectedToInternet = true
        } else {
            self.isConnectedToInternet = false
        }
    }

}
