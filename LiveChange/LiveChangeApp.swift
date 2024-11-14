//
//  LiveChangeApp.swift
//  LiveChange
//
//  Created by YOUZONGYAN on 2024/10/31.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import BackgroundTasks
import ActivityKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
//        BGTaskScheduler.shared.register(
//            forTaskWithIdentifier: "city.uspace.LiveChange.refresh",
//            using: nil
//        ) { task in
//            self.handleAppRefresh(task: task)
//        }
        
        if #available(iOS 17.2, *) {
            Task {
              for try await token in Activity<LiveChangeWidgetAttributes>.pushToStartTokenUpdates {
                let tokenParts = token.map { data in
                  String(format: "%02.2hhx", data)
                }
                let token = tokenParts.joined()
                print("Live activity push to start token updated \(token)")
              }
            }
        }
        
        FirebaseApp.configure()
        
        let settings = Firestore.firestore().settings
        settings.host = "localhost:8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        return true
    }
    
//    func handleAppRefresh(task: BGTask) {
//        scheduleBackgroundTask()
//        
//        task.expirationHandler = {}
//        
//        Task { [weak self] in
//            guard let self else {
//                task.setTaskCompleted(success: false)
//                return
//            }
//            
//            do {
//                // API 取得資料
//                // let data = try? makeHttpRequest()
//                task.setTaskCompleted(success: true)
//            } catch {
//                task.setTaskCompleted(success: false)
//            }
//        }
//    }
//    
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        scheduleBackgroundTask()
//    }
//    
//    func scheduleBackgroundTask() {
//        // 1. 建立 BGTaskRequest
//        let appRefreshTaskRequest = BGAppRefreshTaskRequest(
//            identifier: "city.uspace.LiveChange.refresh"
//        )
//        
//        // 2. 設定屬性，從現在開始算起 15 分鐘後執行
//        appRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
//        
//        do {
//            // 3. 提交
//            try BGTaskScheduler.shared.submit(appRefreshTaskRequest)
//        } catch {
//            print("Could not schedule app refresh: \(error)")
//        }
//        
//    }
}

@main
struct LiveChangeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
    }
}
