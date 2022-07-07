from lor_tools.array.c_array cimport IntCArray


cdef class IntBinarySearch:
    @staticmethod
    def find(array: IntCArray, target, b_return_pos=True):
        """

        :param array: the array to be searched.
        :param target: the target to look for.
        :param b_return_pos: if the target is not found in the array and b_return_pos == True, then the returned value\
        will represent the position the target would take if it were inserted into the array (more concretely, it will\
        return -(insert_pos+1)), else it will simply return -1.
        :return:
        """
        cdef int lo = 0
        cdef int hi = array.size
        cdef int x, val

        while True:
            x = lo + (hi - lo)//2
            val = array.data[x]
            if target == val:
                return x
            elif target > val:
                if lo == x:  # The current value of lo represents the position of the element
                             # 'target' would be inserted after
                    x = -(x+2)  # We return the "insert position" of the target '+1'!
                                # The insert position is the current position +1, hence, we do +2!
                    break
                lo = x
            elif target < val:
                if lo == hi == 0:
                    x = -(x+1)
                    break
                hi = x

        return x if x >= 0 else (x if b_return_pos else -1)
