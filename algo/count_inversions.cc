// The file contains all the 100,000 integers between 1 and 100,000 (including both) in some random order( no integer is repeated).
// 
// Your task is to find the number of inversions in the file given (every row has a single integer between 1 and 100,000). Assume your array is from 1 to 100,000 and ith row of the file gives you the ith entry of the array.
// Write a program and run over the file given. The numeric answer should be written in the space.
// So if your answer is 1198233847, then just type 1198233847 in the space provided without any space / commas / any other punctuation marks. You can make upto 5 attempts, and we'll count the best one for grading.
// (We do not require you to submit your code, so feel free to choose the programming language of your choice, just type the numeric answer in the following space)


#include <iostream>
#include <vector>

using namespace std;

int merge(vector<int> &array, int low, int mid, int high){ 
    //create an new buffer
    //copy array into new buffer
    vector<int> buffer(array);
    
    //merge from the front the left and right halves of the array using the buffer
    int left_half = low;
    int right_half = mid+1;
    int merged = low;
    
    int num_inversions = 0;
    
    while(left_half <= mid && right_half <= high){
        if(buffer[left_half] < buffer[right_half]){
            array[merged] = buffer[left_half];
            left_half++;
        }else{
            //occurrence of an inversion since something in the right half 
            //is greater than the left half
            // mid - left_half is the number of elements remaining in the left half 
            // that is not yet merged into the final array yet.
            num_inversions += (mid - left_half);
            array[merged] = buffer[right_half];
            right_half++;
        }
        merged++;
    }
    
    //copy leftover elements from the left array
    //(since we are growing towards the right half, only the LEFT half need
    // to be copied)
    while(left_half <= mid) {
        array[merged] = buffer[left_half];
        left_half++;
        merged++;
    }
    
    return num_inversions;
}

void print_array(vector<int> &array){
    vector<int>::iterator iter;
    for(iter=array.begin(); iter!=array.end(); iter++){
        cout << *iter << " ";
    }
    cout << endl;
}

int merge_sort(vector<int> &array, int low, int high) {
    //base case
    if(high <= low)
        return;
    
    // int mid = (low + high) / 2;
    int mid = low + (high - low) / 2;
    
    //sort left half
    int count_left = merge_sort(array, low, mid);
    
    //sort right half
    int count_right = merge_sort(array, mid+1, high);
    
    //merge left and right
    int count_split = merge(array, low, mid, high);
    
    return count_left + count_right + count_split;
}

int main() {
    // can treat pointers as iterators
    int a[] = {10,2,3,4,20,6,8,8,9,1};
    int length = sizeof(a)/sizeof(int);
    
    vector<int> array(a, a + length);
    
    print_array(array);
    int num_inversions = merge_sort(array, 0, length-1);
    cout << "total number of inversions in array is " << num_inversions << endl;
    print_array(array);    
}





