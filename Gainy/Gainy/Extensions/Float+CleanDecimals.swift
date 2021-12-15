extension Float {
    var zeroDecimal: String {
        String(format: "%.0f", self)
    }
    
    var cleanOneDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(format: "%.1f", self)
    }

    var cleanTwoDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(format: "%.2f", self)
    }
    
    var zeroDecimalP: String {
        String(format: "%.0f", self) + "%"
    }
    
    var cleanOneDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self) + "%"
            : String(format: "%.1f", self) + "%"
    }
    
    var cleanTwoDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self) + "%"
            : String(format: "%.2f", self) + "%"
    }
}

extension Double {   
    
    var cleanOneDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(format: "%.1f", self)
    }

    var cleanTwoDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(format: "%.2f", self)
    }
    
    var cleanOneDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self) + "%"
            : String(format: "%.1f", self) + "%"
    }
}
