//
//  UITableViewHeaderFooterView + dequeue.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.12.2024.
//

import UIKit

extension UITableView {
    
    func registerHeaderFooterView<View: UITableViewHeaderFooterView>(_ viewClass: View.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseId)
    }

    func dequeueHeader<View: UITableViewHeaderFooterView>() -> View {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: View.reuseId) as? View
        else { fatalError("Fatal error for cell at \(indexPath)") }
        return view
    }
}

extension UITableViewHeaderFooterView: Reusable {}

extension Reusable where Self: UITableViewHeaderFooterView {
    static var reuseId: String {
        String(describing: self)
    }
}
