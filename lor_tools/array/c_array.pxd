cdef class IntCArray:
    cdef int size
    cdef int* data

    cdef int* get_array(self)
