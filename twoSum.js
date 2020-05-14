const zip = (arr1, arr2) => arr1.map((ele, ind) => [ele, arr2[ind]]);

/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
    
    const map = new Map(zip(nums, [...Array(nums.length).keys()]));
    
    for(let i = 0; i < nums.length; i++) {
        const res = map.get(target - nums[i]);
        
        if(res && res !== i)
            return [i, res];
    }
    
    
};
