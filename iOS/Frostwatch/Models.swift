import Foundation

struct CropWindow: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var cropName: String
    var lastFrostDate: Date
    var firstFrostDate: Date
    var weeksAfterLastFrost: Int

    init(id: UUID = UUID(), cropName: String = "", lastFrostDate: Date = Date(), firstFrostDate: Date = Date(), weeksAfterLastFrost: Int = 0) {
        self.id = id
        self.cropName = cropName
        self.lastFrostDate = lastFrostDate
        self.firstFrostDate = firstFrostDate
        self.weeksAfterLastFrost = weeksAfterLastFrost
    }
}
