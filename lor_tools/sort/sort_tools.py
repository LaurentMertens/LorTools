"""

.. codeauthor:: Laurent Mertens <laurent.mertens@kuleuven.be>
"""


class SortTools:
    @staticmethod
    def sort_together(a, b):
        """
        Sort two lists, a and b, together. To be precise, list a will be sorted, and list b will follow the same sorting.\
        E.g., if you have a = [3,2,1] and b = [2,3,1], the the result of this operation will be a = [1,2,3], b = [1,3,2].\

        Taken from https://stackoverflow.com/questions/13668393/python-sorting-two-lists
        :param a:
        :param b:
        :return: sorted(a), sorted_together(b)
        """
        a, b = [list(x) for x in zip(*sorted(zip(a, b), key=lambda pair: pair[0]))]
        return a, b
