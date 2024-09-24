# MergeSort
### `Description`: Split the array into two halves and recursively sort them. Then merge the two sorted halves.
### `Time Complexity`: O(nlogn) in all cases
### `Recommended use`: When you need a stable sort and have a large dataset.

## Implementation:
### `Explanation`:

- `Merge function`: The merge function takes two sorted subarrays and merges them into a single sorted array.<br>
  It uses two temporary arrays leftArray and rightArray to hold the data, then combines them by comparing the elements.<br><br>

- `MergeSort function`: The recursive function mergeSort splits the array in half to obtain single-element subarrays, which are automatically sorted.<br>
  It then calls the merge function to merge the sorted subarrays.

### `Code`:
```java
public class MergeSort {

    public static void main(String[] args) {

        int[] array = {38, 27, 43, 3, 9, 82, 10};

        System.out.println("Original Array:");
        System.out.println(Arrays.toString(array));

        mergeSort(array, 0, array.length - 1);

        System.out.println("Sorted Array:");
        System.out.println(Arrays.toString(array));
    }

    // Main function that sorts array
    private static void mergeSort(int[] array, int left, int right) {
        if (left < right) {
            //Find the middle point to divide the array into two halves
            int middle = left + (right - left) / 2;

            // Sort first and second halves
            mergeSort(array, left, middle);
            mergeSort(array, middle + 1, right);

            // Merge the sorted halves
            merge(array, left, middle, right);
        }
    }

    private static void merge(int[] array, int left, int middle, int right) {
        // Find sizes of two subarrays to be merged
        int n1 = middle - left + 1;
        int n2 = right - middle;

        // Create temp arrays
        int[] leftArray = new int[n1];
        int[] rightArray = new int[n2];

        // Copy data to temp arrays
        for (int i = 0; i < n1; i++) {
            leftArray[i] = array[left + i];
        }
        for (int j = 0; j < n2; j++) {
            rightArray[j] = array[middle + 1 + j];
        }

        // Merge the temp arrays
        int i = 0, j = 0;

        // Initial index of merged subarray array   
        int k = left;
        while (i < n1 && j < n2) {
            if (leftArray[i] <= rightArray[j]) {
                array[k] = leftArray[i];
                i++;
            } else {
                array[k] = rightArray[j];
                j++;
            }
            k++;
        }

        // Copy the remaining elements of leftArray when rightArray is empty
        while (i < n1) {
            array[k] = leftArray[i];
            i++;
            k++;
        }

        // Copy the remaining elements of rightArray when leftArray is empty
        while (j < n2) {
            array[k] = rightArray[j];
            j++;
            k++;
        }
    }


}

```