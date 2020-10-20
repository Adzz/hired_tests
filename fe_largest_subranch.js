// Suppose you're given a binary tree represented as an array. For example, [3,6,2,9,-1,10]
// represents the following binary tree (where -1 is a non-existent node):

     //            3
     //         /    \
     //        6     2
     //      /      /
     //     9     10

// Write a function that determines whether the left or right branch of the tree is larger.
// The size of each branch is the sum of the node values. The function should return the
// string "Right" if the right side is larger and "Left" if the left side is larger. If t
// he tree has 0 nodes or if the size of the branches are equal, return the empty string.

// Example Input:

// [3,6,2,9,-1,10]

// Example Output:

// "Left"


const solution = (arr) => {
    const arrLength = arr

    if (arrLength === 0) {
        return ""
    } else {
      return toTree(arr)
    }
};

function toTree(list) {
  const [root, ...rest] = list
  var iteration = 1;
  var leftCount = 0;
  var rightCount = 0;
  // The insight is that to get the left elements we need to
  // Get goes from 1 to 2 to 4 to 8... that is 2^i / 2.
  // destructively get the elements, then getting the right elements is easy
  // we get left elements first then the right, then iterate.
  while (rest.length > 0) {
    const elementsToRemove = Math.pow(2, iteration) / 2
    const left = rest.splice(0, elementsToRemove)
    const right = rest.splice(0, elementsToRemove)
    rightCount = right.reduce((a, b) => a + b, rightCount)
    leftCount = left.reduce((a, b) => a + b, leftCount)
    iteration ++
  }

  if (leftCount > rightCount) {
    return "Left"
  } else if (rightCount > leftCount) {
    return "Right"
  } else {
    return ""
  }
}
