import UIKit

// Breadth-First traversal or Level-order traversal
// BFT- Start's from the root node 1, then visits the children (2 , 3) from left to right, then traverses the 2 nodes children from left to right (4, 5), if there were
// for general trees we would look through an array and search through that
// for Binary trees
// Goal is to return 1,2,3,4,5

class BinaryTreeNode<T> {
  var value: T // T is a generic, can hold any data type
  var leftChild: BinaryTreeNode?
  var rightChild: BinaryTreeNode?
  init(_ value: T) {
    self.value = value
  }
}

// Uses a queue to keep track of the visited Nodes
// we use an array based queue
// FIFO - The first one i see is the first one i want to print


struct Queue<T> {
    private var elements = [T]()

    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    public var peek: T? {
        return elements.first
    }
    
    // We say mutating since it changes the state of elements
    // We wouldn't have to do that in a class since it can chane at any time
    // This adds an element to the back (FIFO)
    
    public mutating func enqueue(_ item: T) {
        elements.append(item) // constant time 0(1), we just add it to the end we dont traverse anything
    }
    
    // removes the first element from the front of the queue
    public mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst() // O(n) //we will optimize post CTA
    }
}

let rootNode = BinaryTreeNode<Int>(1)
let twoNode = BinaryTreeNode<Int>(2)
let threeNode = BinaryTreeNode<Int>(3)
let fourNode = BinaryTreeNode<Int>(4)
let fiveNode = BinaryTreeNode<Int>(5)

rootNode.leftChild = twoNode
rootNode.rightChild = threeNode
twoNode.leftChild = fourNode
twoNode.rightChild = fiveNode


// We put this in a QUEUE structure to store the values
// We check to see if each child has a node

// Constucting a tree from scratch
/*
    root
     1
    / \
   2   3
  / \
 4   5
 */



extension BinaryTreeNode {
    // This closure below keeps track of the nodes that we are visiting
    // Instead of printing them in the function
    func breadthFirstTraversal(visit: (BinaryTreeNode) -> ()) {
        // using a queue to keep track of the nodes as they are being visited
        var queue = Queue<BinaryTreeNode>()
        visit(self) // self represents the root node
        // visit self is capturing the current node sas opposed to printing the node in this method.
        
        queue.enqueue(self) // this adds a root node to the qqueue
        // We are adding the root node to the queue in order to also visit it's children (left, right child)
        
        while let node = queue.dequeue() {
            // checks for a left child and enqueues as needed
            // can be changed to a variable
            
            if let leftChild = node.leftChild { // optional binding
                visit(leftChild)
                queue.enqueue(leftChild)
            }
            // checks for right child and enqueue as needed
            if let rightChild = node.rightChild {
                visit(rightChild)
                queue.enqueue(rightChild)
            }
        }
    }
}

// Test for BFT
print("breadth-first Traversl")
rootNode.breadthFirstTraversal { (node) in
    print
    print(node.value, terminator: " ") // terminator will allow averything to be printed on the same line
}


