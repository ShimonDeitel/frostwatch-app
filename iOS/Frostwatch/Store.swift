import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [CropWindow] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "frostwatch_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([CropWindow].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: CropWindow) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: CropWindow) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: CropWindow) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [CropWindow] {
        [
        CropWindow(cropName: "Tomatoes", lastFrostDate: Date().addingTimeInterval(-259200), firstFrostDate: Date().addingTimeInterval(-259200), weeksAfterLastFrost: 1),
        CropWindow(cropName: "Peas", lastFrostDate: Date().addingTimeInterval(-518400), firstFrostDate: Date().addingTimeInterval(-518400), weeksAfterLastFrost: 2),
        CropWindow(cropName: "Lettuce", lastFrostDate: Date().addingTimeInterval(-777600), firstFrostDate: Date().addingTimeInterval(-777600), weeksAfterLastFrost: 3),
        CropWindow(cropName: "Tomatoes", lastFrostDate: Date().addingTimeInterval(-1036800), firstFrostDate: Date().addingTimeInterval(-1036800), weeksAfterLastFrost: 4)
        ]
    }
}
