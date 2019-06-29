//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by Gen Tamura on 2014/09/14.
//  Copyright (c) 2014年 Gen Tamura. All rights reserved.
//

import Foundation

struct TODO {
  var title:String
}

class TodoDataManager {
  var todoList: [TODO]
  
  init() {
    self.todoList = []
  }
  
  class func validate(todo: TODO!) -> Bool {
    return todo != nil && todo != ""
  }
  
  func create(todo: TODO!) -> Bool {
    if TodoDataManager.validate(todo) {
      self.todoList += todo
      return true
    }
    return false
  }
  
  
}