import RxDataSources

struct SectionOfWindows: SectionModelType {
    typealias Item = WindowViewData
    var header: String
    var items: [Item]
}
    
extension SectionOfWindows: AnimatableSectionModelType {
    typealias Identity = String
    var identity: String { header }
    
    init(original: SectionOfWindows, items: [WindowViewData]) {
        self = original
        self.items = items
    }
}
