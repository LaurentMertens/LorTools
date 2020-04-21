# Adapted from https://stackoverflow.com/questions/9501337/binary-search-algorithm-in-python
# Also: https://stackoverflow.com/questions/212358/binary-search-bisection-in-python


class BinarySearch:
    @staticmethod
    def find(array, target, b_return_pos=True):
        """

        :param array: the array to be searched
        :param target: the target to look for
        :param lo:
        :param hi:
        :param b_return_pos: if the target is not found in the array and b_return_pos == True, then the returned value
        will represent the position the target would take if it were inserted into the array (more concretely, it will
        return -(insert_pos)), else it will simply return -1
        :return:
        """
        lo = 0
        hi = len(array)

        while True:
            x = lo + (hi - lo)//2
            val = array[x]
            if target == val:
                return x
            elif target > val:
                if lo == x:  # The current value of lo represents the position of the element
                             # 'target' would be inserted after
                    x = -(x+1)
                    break
                lo = x
            elif target < val:
                if lo == hi == 0:
                    x = -(x+1)
                    break
                hi = x

        return x if x >= 0 else (x if b_return_pos else -1)
