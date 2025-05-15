class tableSection{
    var sectionData: String
    var arrRow: [tableRow]
    var expandValue: Bool
    
    init(sectionData:String,expandValue: Bool,arrRow: [tableRow]) {
        self.sectionData = sectionData
        self.expandValue = expandValue
        self.arrRow = arrRow
    }
}
class tableRow{
    var rowData: String
    
    init(rowData:String) {
        self.rowData = rowData
    }
}
