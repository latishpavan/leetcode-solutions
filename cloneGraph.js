/**
 * // Definition for a Node.
 * function Node(val, neighbors) {
 *    this.val = val === undefined ? 0 : val;
 *    this.neighbors = neighbors === undefined ? [] : neighbors;
 * };
 */

/**
 * @param {Node} node
 * @return {Node}
 */

function cloneValues(node, clonedNodes) {
    if(clonedNodes.has(node.val))
        return clonedNodes.get(node.val);
    
    const newNode = new Node(node.val);
    clonedNodes.set(node.val, newNode);
    
    for (const neighbor of node.neighbors) {
        newNode.neighbors.push(cloneValues(neighbor, clonedNodes));
    }
    
    return newNode
}

function cloneGraph(node) {
    if(!node) return node;
    
    const clonedNodes = new Map()
    return cloneValues(node, clonedNodes);
}
