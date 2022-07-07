# Adapted from https://www.tutorialspoint.com/data_structures_algorithms/quick_sort_program_in_c.htm
from lor_tools.array.c_array cimport IntCArray


cdef class CQuickSort:
    @staticmethod
    def sort(a: IntCArray, left: int=0, right: int=-1):
        cdef int pivot
        cdef int partitionPoint
        if right == -1:
            right = a.size - 1

        if (right-left <= 0):
            return
        else:
            partitionPoint = CQuickSort._partition(a.data, left, right)
            CQuickSort.sort(a, left, partitionPoint-1)
            CQuickSort.sort(a, partitionPoint+1, right)

    @staticmethod
    cdef _swap(int *data, int idx1, int idx2):
        cdef int temp = data[idx1]
        data[idx1] = data[idx2]
        data[idx2] = temp

    @staticmethod
    cdef _partition(int *data, int left, int right):
        cdef int pivot = data[right]
        print(f"Pivot: {pivot} at index {right} :: left={left}")
        cdef int leftPointer = left -1;
        cdef int rightPointer = right;

        while True:
            leftPointer += 1
            while (data[leftPointer] < pivot):
                leftPointer += 1

            rightPointer -= 1
            while(rightPointer > 0 and data[rightPointer] > pivot):
                rightPointer -= 1

            if (leftPointer >= rightPointer):
                print(f"leftPointer >= rightPointer: {leftPointer} >= {rightPointer}")
                break
            elif (data[leftPointer] < data[rightPointer]):
                print(f" item swapped :{leftPointer}:{data[leftPointer]} <-> {rightPointer}:{data[rightPointer]}\n")
                CQuickSort._swap(data, leftPointer, rightPointer)

        if (data[leftPointer] != data[right]) and (right != rightPointer):
            print(f" pivot swapped :: {leftPointer}:{data[leftPointer]} <-> {right}:{data[right]}\n")
            CQuickSort._swap(data, leftPointer, right)
        return leftPointer


# Sort multiple IntCArrays together; the first one is sorted, the other ones follow along.
cdef class CQuickSortMulti:
    @staticmethod
    def sort(leader: IntCArray, pack: [IntCArray], left: int=0, right: int=-1):
        for l in pack:
            if l.get_size() != leader.size:
                raise ValueError("All IntCArrays should have the same size!")

        cdef int pivot
        cdef int partitionpoint
        if right == -1:
            right = leader.size - 1

        if (right-left <= 0):
            return
        else:
            pivot = leader.data[right];
#            print(f"Pivot: {pivot} at index {right}")
            partitionPoint, rP, r = CQuickSortMulti._partition(leader.data, left, right, pivot)
            for e in pack:
                if partitionPoint < rP:
                    e.swap_items(partitionPoint, rP)
                e.swap_items(partitionPoint, r)
            CQuickSortMulti.sort(leader, pack, left, partitionPoint-1)
            CQuickSortMulti.sort(leader, pack, partitionPoint+1, right)

    @staticmethod
    cdef _swap(int *data, int idx1, int idx2):
        cdef int temp = data[idx1]
        data[idx1] = data[idx2]
        data[idx2] = temp

    @staticmethod
    cdef _partition(int *data, int left, int right, int pivot):
        cdef int leftPointer = left -1;
        cdef int rightPointer = right;

        while True:
            leftPointer += 1
            while(data[leftPointer] < pivot):
                leftPointer += 1

            rightPointer -= 1
            while(rightPointer > 0 and data[rightPointer] > pivot):
                rightPointer -= 1

            if (leftPointer >= rightPointer) or (data[leftPointer] == data[rightPointer]):
                break
            else:
#                print(f" item swapped :{data[leftPointer]},{data[rightPointer]}\n")
                CQuickSort._swap(data, leftPointer, rightPointer)

        if (data[leftPointer] != data[right]) and (right != rightPointer):
#            print(f" pivot swapped :{data[leftPointer]},{data[right]}\n")
            CQuickSort._swap(data, leftPointer, right)
#        print("Updated Array: ")
        return leftPointer, rightPointer, right
