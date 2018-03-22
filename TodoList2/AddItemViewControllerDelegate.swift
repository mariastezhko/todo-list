//
//  AddItemDelegate.swift
//  TodoList2
//
//  Created by Maria Stezhko on 3/20/18.
//  Copyright © 2018 Maria Stezhko. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class {
    func itemSaved(by controller: AddItemViewController, title: String, notes: String, date: String, at indexPath: NSIndexPath?)
}
