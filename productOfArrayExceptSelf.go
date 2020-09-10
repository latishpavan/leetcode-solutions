func productExceptSelf(nums []int) []int {
    length := len(nums)
    left, right := make([]int, length), make([]int, length)
    left[0], right[length - 1] = nums[0], nums[length - 1]
    
    for i := 1; i < length; i++ {
        left[i] = left[i - 1] * nums[i]
        right[length - i - 1] = right[length - i] * nums[length - i - 1]
    }
    
    out := make([]int, length)
    out[0] = right[1]
    out[length - 1] = left[length - 2]
    
    for i := 1; i < length - 1; i++ {
        out[i] = left[i - 1] * right[i + 1]
    }
    
    return out
}