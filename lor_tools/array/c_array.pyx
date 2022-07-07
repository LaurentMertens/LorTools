"""

.. codeauthor:: Laurent Mertens <laurent.mertens@kuleuven.be>
"""
cimport lor_tools.array.c_array
from libc.stdlib cimport malloc, free


cdef class Test:
    cdef int* data1
    cdef int* data2

    def __cinit__(self):
        self.data1 = <int *> malloc(10 * sizeof(int))
        self.data2 = <int *> malloc(10 * sizeof(int))

        for i in range(10):
            self.data1[i] = 10 - i
            self.data2[i] = i



cdef class IntCArray:
    def __cinit__(self, size: int, data: list=None):
        self.size = size
        self.data = <int *> malloc(self.size * sizeof(int))
        if not self.data:
            raise MemoryError()

        if data is not None:
            for idx, i in enumerate(data):
                self.data[idx] = i

    def set_item(self, idx: int, i: int):
        if idx >= self.size:
            raise IndexError(f'Requested index {idx} exceeds array length of {self.size}.')
        self.data[idx] = i

    def get_item(self, idx: int):
        if idx >= self.size:
            raise IndexError(f'Requested index {idx} exceeds array length of {self.size}.')
        return self.data[idx]

    def swap_items(self, idx1:int , idx2: int):
        cdef int temp = self.data[idx1]
        self.data[idx1] = self.data[idx2]
        self.data[idx2] = temp

    cdef int* get_array(self):
        return self.data

    def get_data(self):
        l = [self.data[i] for i in range(self.size)]
        return l

    def get_size(self):
        return int(self.size)

cdef class DoubleCArray:
    cdef int size
    cdef double* data

    def __cinit__(self, l: list):
        self.size = len(l)
        self.data = <double *> malloc(self.size * sizeof(double))
        if not self.data:
            raise MemoryError()

        for idx, i in enumerate(l):
            self.data[idx] = i

    def get_item(self, idx: int):
        if idx >= self.size:
            raise IndexError(f'Requested index {idx} exceeds array length of {self.size}.')
        return self.data[idx]

cdef class FloatCArray:
    cdef int size
    cdef float* data

    def __cinit__(self, l: list):
        self.size = len(l)
        self.data = <float *> malloc(self.size * sizeof(float))
        if not self.data:
            raise MemoryError()

        for idx, i in enumerate(l):
            self.data[idx] = i

    def get_item(self, idx: int):
        if idx >= self.size:
            raise IndexError(f'Requested index {idx} exceeds array length of {self.size}.')
        return self.data[idx]