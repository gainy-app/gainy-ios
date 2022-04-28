extension Float {
    var zeroDecimal: String {
        String(format: "%.0f", locale: .current, self)
    }
    
    var cleanOneDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self)
            : String(format: "%.1f", locale: .current, self)
    }

    var cleanTwoDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self)
            : String(format: "%.2f", locale: .current, self)
    }
    
    var cleanTwoDecimalUnsigned: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self).replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
            : String(format: "%.2f", locale: .current, self).replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
    }
    
    var zeroDecimalP: String {
        String(format: "%.0f", locale: .current, self) + "%"
    }
    
    var cleanOneDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self) + "%"
            : String(format: "%.1f", locale: .current, self) + "%"
    }
    
    var cleanTwoDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self) + "%"
            : String(format: "%.2f", locale: .current, self) + "%"
    }
}

extension Double {   
    
    var cleanOneDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self)
            : String(format: "%.1f", locale: .current, self)
    }

    var cleanTwoDecimal: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self)
            : String(format: "%.2f", locale: .current, self)
    }
    
    var cleanOneDecimalP: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", locale: .current, self) + "%"
            : String(format: "%.1f", locale: .current, self) + "%"
    }
}
