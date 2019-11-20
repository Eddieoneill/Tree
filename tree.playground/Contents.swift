import UIKit

public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0

  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }

  public mutating func dequeue() -> T? {
    guard let element = array[guarded: head] else { return nil }

    array[head] = nil
    head += 1

    let percentage = Double(head)/Double(array.count)
    if array.count > 50 && percentage > 0.25 {
      array.removeFirst(head)
      head = 0
    }

    return element
  }

  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}


class TreeNode {
    let val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int) {
        self.val = val
    }
}

func traverse(_ root: TreeNode?) {
    guard let root = root else { return }
    
    print(root.val)
    traverse(root.left)
    traverse(root.right)
}

func breadthFirstTraversal(_ root: TreeNode?) {
    guard let root = root else { return }
    
    var queue = Queue<TreeNode>()
    
    queue.enqueue(root)
    
    while !queue.isEmpty {
        let currentNode = queue.dequeue()!
        print(currentNode.val)
        
        if let leftChild = currentNode.left {
            queue.enqueue(leftChild)
        }
        
        if let rightChild = currentNode.right {
            queue.enqueue(rightChild)
        }
    }
    
}

let one = TreeNode(val: 1)
let two = TreeNode(val: 2)
let three = TreeNode(val: 3)
let four = TreeNode(val: 4)
let five = TreeNode(val: 5)
let six = TreeNode(val: 6)
let seven = TreeNode(val: 7)
let eight = TreeNode(val: 8)

one.left = two
one.right = three

three.left = six
three.right = seven

two.left = four
two.right = five

six.left = eight

breadthFirstTraversal(one)
