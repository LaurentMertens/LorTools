import unittest
from lor_tools.search.binary_search import BinarySearch as bs


class TestBinarySearch(unittest.TestCase):
    def test_binary_search(self):
        a = [1, 2, 3, 4, 6, 7, 8, 9]
        self.assertEqual(-1, bs.find(a, 0))
        self.assertEqual(-4, bs.find(a, 5))
        self.assertEqual(-8, bs.find(a, 10))
        self.assertEqual(-1, bs.find(a, 10, b_return_pos=False))
        self.assertEqual(3, bs.find(a, 4))
