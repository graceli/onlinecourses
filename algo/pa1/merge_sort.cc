#include <iostream>
#include <vector>

using namespace std;

void merge(vector<int> &array, int low, int mid, int high){ 
    //create an new buffer
    //copy array into new buffer
    vector<int> buffer(array);
    
    //merge from the front the left and right halves of the array using the buffer
    int left_half = low;
    int right_half = mid+1;
    int merged = low;
    
    while(left_half <= mid && right_half <= high){
        if(buffer[left_half] < buffer[right_half]){
            array[merged] = buffer[left_half];
            left_half++;
        }else{
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
}

void print_array(vector<int> &array){
    vector<int>::iterator iter;
    for(iter=array.begin(); iter!=array.end(); iter++){
        cout << *iter << " ";
    }
    cout << endl;
}

void merge_sort(vector<int> &array, int low, int high) {
    //base case
    if(high <= low)
        return;
    
    // int mid = (low + high) / 2;
    int mid = low + (high - low) / 2;
    
    //sort left half
    merge_sort(array, low, mid);
    
    //sort right half
    merge_sort(array, mid+1, high);
    
    //merge left and right
    merge(array, low, mid, high);
    
}

int main() {
    // can treat pointers as iterators
    int a[] = {10,2,3,4,20,6,8,8,9,1};
    int length = sizeof(a)/sizeof(int);
    
    vector<int> array(a, a + length);
    
    print_array(array);
    merge_sort(array, 0, length-1);
    print_array(array);    
}





