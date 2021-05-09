//
//  Extensions.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import Foundation
import UIKit

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
      let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
        color.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
      }
      setBackgroundImage(colorImage, for: controlState)
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}

extension Array {
    static func filterNils(_ array: [Element?]) -> [Element] {
        return array.filter { $0 != nil }.map { $0! }
    }
}

