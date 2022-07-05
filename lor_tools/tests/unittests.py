import unittest
from lor_tools.search.binary_search import BinarySearch as bs
from lor_tools.sort.sort_tools import SortTools


class TestBinarySearch(unittest.TestCase):
    def test_binary_search(self):
        a = [1, 3, 4, 6, 7, 8, 9]
        self.assertEqual(-1, bs.find(a, -5))
        self.assertEqual(-1, bs.find(a, 0))
        self.assertEqual(-2, bs.find(a, 2))
        self.assertEqual(-4, bs.find(a, 5))
        self.assertEqual(-8, bs.find(a, 10))
        self.assertEqual(-1, bs.find(a, 10, b_return_pos=False))
        self.assertEqual(2, bs.find(a, 4))


class TestSortTogether(unittest.TestCase):
    def test_sort_together(self):
        a = [5, 4, 3, 3, 2, 1]
        b = [3, 2, 4, 6, 1, 5]
        c, d = SortTools.sort_together(a, b)
        self.assertListEqual(c, [1, 2, 3, 3, 4, 5])
        self.assertListEqual(d, [5, 1, 4, 6, 2, 3])
