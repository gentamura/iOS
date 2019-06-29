//
//  Array2D.swift
//  Swiftris
//
//  Created by Gen Tamura on 2015/06/06.
//  Copyright (c) 2015年 Gen Tamura. All rights reserved.
//


// #1
class Array2D<T> {
  let columns: Int
  let rows: Int
  
  // #2
  var array: Array<T?>
  
  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
    
    array = Array<T?>(count:rows * columns, repeatedValue: nil)
  }
  
  subscript(column: Int, row: Int) -> T? {
    get {
      return array[(row * columns) + columns]
    }
    set(newValue) {
      array[(row * columns) + column] = newValue
    }
  }
}