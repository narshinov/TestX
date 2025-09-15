import SwiftUI
import SwiftData

@main
struct TestXApp: App {
    
    private let sharedModelContainer: ModelContainer
    
    init() {
        let sharedModelContainer = {
            let schema: Schema = Schema([PhotoEntry.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }()
        
        self.sharedModelContainer = sharedModelContainer
    }
    
    var body: some Scene {
        WindowGroup {
            CoreView(modelContainer: sharedModelContainer)
                .modelContainer(sharedModelContainer)
        }
    }
}
