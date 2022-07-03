# Adapted from https://stackoverflow.com/questions/9501337/binary-search-algorithm-in-python
# Also: https://stackoverflow.com/questions/212358/binary-search-bisection-in-python
import os.path


class BinarySearch:
    @staticmethod
    def find(array, target, b_return_pos=True):
        """

        :param array: the array to be searched.
        :param target: the target to look for.
        :param b_return_pos: if the target is not found in the array and b_return_pos == True, then the returned value\
        will represent the position the target would take if it were inserted into the array (more concretely, it will\
        return -(insert_pos+1)), else it will simply return -1.
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

    @staticmethod
    def find_in_file(file, target, startpos_lines=None, b_binary=False, b_return_pos=True):
        """
        Same principle as "find", only this method assumes the input is a text or binary file where each line
        contains one value.

        :param file: the file to be searched.
        :param target: the target to look for.
        :param startpos_lines: sorted list containing the starting positions of the lines in the file;\
        if None, will initialize here
        :param b_binary: whether the file is a binary file or not.
        :param b_return_pos: if the target is not found in the array and b_return_pos == True, then the returned value\
        will represent the position the target would take if it were inserted into the array (more concretely, it will\
        return -(insert_pos+1)), else it will simply return -1.
        :return:
        """
        mode = 'rb' if b_binary else 'r'

        # Get positions of newlines in file
        if startpos_lines is None:
            startpos_lines = [0]
            with open(file, mode) as fin:
                for _ in fin:
                    startpos_lines.append(fin.tell())
            # Remove last item, which is EOF position
            startpos_lines = startpos_lines[:-1]

        lo = 0
        hi = len(startpos_lines)

        with open(file, mode) as fin:
            while True:
                x = lo + (hi - lo)//2

                # Set position in file at start of line x
                fin.seek(startpos_lines[x])

                # Read line at position x
                val = fin.readline().strip()
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


if __name__ == '__main__':
    _file = os.path.join(os.sep, 'mnt', 'DataMorry', 'Work', 'Projects', 'SemWebChallenge', 'Data', 'tokens.bin')
    print(BinarySearch.find_in_file(file=_file, target=b'Belgium', b_binary=True))
