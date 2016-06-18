//
//  Row.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

public class Row {
    
    /// The cell identifier
    public var identifier: String?
    
    /// Defines if it need be rendered or not when reload the table.
    public var visible = true
    
    var editingStyle = UITableViewCellEditingStyle.None
    var movable = false
    var deleteConfirmation: String?
    
    /// Read only property that indicate if the row is movable.
    public var canMove: Bool {
        return movable
    }
    
    /// Read only property that indicate if the row is deletable.
    public var canDelete: Bool {
        return editingStyle == .Delete
    }
    
    /// Read only property that indicate if the row is insertable. (not implemented yet)
    private var canInsert: Bool {
        return editingStyle == .Insert
    }
    
    /// Read only property that indicate if the row is editable. Will be true if the row can perform any of this actions: move, delete or insert.
    public var canEdit: Bool {
        return canMove || canDelete || canInsert
    }
    
    /// The object that can be used in the closure's impementation.
    public var object: AnyObject?
    
    /// The closure that will be called when the table request the cell.
    public var configuration: Configuration?
    
    /// The closure that will be called when the cell was selected.
    public var didSelect: DidSelect?
    
    /// The closure that will be called when the table request the row's height.
    public var heightForRow: HeightForRow?
    
    /// Initializes a new Row. All parameters are optionals.
    public required init(identifier: String? = nil, visible: Bool = true, object: AnyObject? = nil) {
        self.identifier = identifier
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Set a identifier to use a custom cell
    public func setIdentifier(identifier: String) {
        self.identifier = identifier
    }
    
    /// Set object that can be used in the closure's impementation.
    public func setObject(object: AnyObject) {
        self.object = object
    }
    
    /// Define if the row can be moved
    public func setCanMove(movable: Bool) {
        self.movable = movable
    }
    
    /// Define if the row can be deleted
    public func setCanDelete(deletable: Bool, titleForDeleteConfirmation: String? = nil) {
        self.editingStyle = deletable ? .Delete : .None
        self.deleteConfirmation = titleForDeleteConfirmation
    }
    
    /// Define if the row can be inserted (not implemented yet)
    private func setCanInsert(insertable: Bool) {
        self.editingStyle = insertable ? .Insert : .None
    }
    
    /// Set closure that will be called when the table request the cell.
    public func setConfiguration(block: Configuration) {
        self.configuration = block
    }
    
    /// Set closure that will be called when the cell was selected.
    public func setDidSelect(block: DidSelect) {
        self.didSelect = block
    }
    
    /// Set the row's height using a closure that will be called when the table request the a height
    public func setHeight(withDynamicHeight dynamicHeight: HeightForRow) {
        heightForRow = dynamicHeight
    }
    
    /// Set the row's height using a static height
    public func setHeight(withStaticHeight staticHeight: Double) {
        setHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForRow = (row: Row, tableView: UITableView, index: Int) -> Double
    public typealias Configuration = (row: Row, cell: UITableViewCell, indexPath: NSIndexPath) -> Void
    public typealias DidSelect = (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void
}
