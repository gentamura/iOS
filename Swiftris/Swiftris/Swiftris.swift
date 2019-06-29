//
//  Swiftris.swift
//  Swiftris
//
//  Created by Gen Tamura on 2015/06/06.
//  Copyright (c) 2015年 Gen Tamura. All rights reserved.
//

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

protocol SwiftrisDelegate {
  // Invoked when the current round of Swiftris ends
  func gameDidEnd(swiftris: Swiftris)
  
  // Invoked immediately after a new game has begun
  func gameDidBegin(swiftris: Swiftris)
  
  // Invoked when the falling shape has become part of the game board
  func gameShapeDisLand(swiftris: Swiftris)
  
  // Invoked when the falling shape has changed its location
  func gameShapeDidMove(swiftris: Swiftris)
  
  // Invoked when the falling shape has changed its location after being dropped
  func gameShapeDidDrop(swiftris: Swiftris)
  
  // Invoked when the game has reached a new level
  func gameDidLevelUp(swiftris: Swiftris)
}

class Swiftris {
  var blockArray:Array2D<Block>
  var nextShape:Shape?
  var fallingShape:Shape?
  var delegate:SwiftrisDelegate?
  
  init() {
    fallingShape = nil
    nextShape = nil
    blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
  }
  
  func beginGame() {
    if (nextShape == nil) {
      nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
      fallingShape?.moveTo(StartingColumn, row: StartingRow)
    }
    delegate?.gameDidBegin(self)
  }
  
  func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
    fallingShape = nextShape
    nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
    fallingShape?.moveTo(StartingColumn, row: StartingRow)
    
    if detectIllegalPlacement() {
      nextShape = fallingShape
      nextShape!.moveTo(PreviewColumn, row: PreviewRow)
      endGame()
      return (nil, nil)
    }
    return (fallingShape, nextShape)
  }
  
  func detectIllegalPlacement() -> Bool {
    if let shape = fallingShape {
      for block in shape.blocks {
        if block.column < 0 || block.column >= NumColumns || block.row < 0 || block.row >= NumRows {
          return true
        } else if blockArray[block.column, block.row] != nil {
          return true
        }
      }
    }
    return false
  }
  
  func settleShape() {
    if let shape = fallingShape {
      for block in shape.blocks {
        blockArray[block.column, block.row] = block
      }
      fallingShape = nil
      delegate?.gameShapeDidLand(self)
    }
  }
  
  func detectTouch() -> Bool {
    if let shape = fallingShape {
      for bottomBlock in shape.bottomBlocks {
        if bottomBlock.row == NumRows - 1 ||
          blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
            return true
        }
      }
    }
    return false
  }
  
  func endGame() {
    delegate?.gameDidEnd(self)
  }
  
  func dropShape() {
    if let shape = fallingShape {
      while detectIllegalPlacement() == false {
        shape.lowerShapeByOneRow()
      }
      shape.raiseShapeByOneRow()
      delegate?.gameShapeDidDrop(self)
    }
  }
  
  func letShapeFall() {
    if let shape = fallingShape {
      shape.lowerShapeByOneRow()
      if detectIllegalPlacement() {
        shape.raiseShapeByOneRow()
        if detectIllegalPlacement() {
          endGame()
        } else {
          settleShape()
        }
      } else {
        delegate?.gameShapeDidMove(self)
        if detectTouch() {
          settleShape()
        }
      }
    }
  }
  
  func rotateShape() {
    if let shape = fallingShape {
      shape.rotateClockwise()
      if detectIllegalPlacement() {
        shape.rotateCounterClockwise()
      } else {
        delegate?.gameShapeDidMove(self)
      }
    }
  }
  
  func moveShapeLeft() {
    if let shape = fallingShape {
      shape.shiftLeftByOneColumn()
      if detectIllegalPlacement() {
        shape.shiftRightByOneColumn()
        return
      }
      delegate?.gameShapeDidMove(self)
    }
  }
  
  func moveShapeRight() {
    if let shape = fallingShape {
      shape.shiftRightByOneColumn()
      if detectIllegalPlacement() {
        shape.shiftLeftByOneColumn()
        return
      }
      delegate?.gameShapeDidMove(self)
    }
  }
  
}
