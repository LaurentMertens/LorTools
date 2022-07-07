from Cython.Build import cythonize
from setuptools import setup, find_packages, Extension

setup(
    python_requires='>=3.6',
    name='lor-tools',
    version='1.0',
    packages=find_packages(exclude=['tests']),
    url='',
    license='MIT',
    author='Laurent Mertens',
    author_email='laurent.mertens@outlook.com',
    description='A collection of tools that can come in handy. Super descriptive, innit!?',
    install_requires=[],
    ext_modules=cythonize(['lor_tools/array/c_array.pyx',
                           'lor_tools/search/c_binary_search.pyx',
                           'lor_tools/sort/c_quicksort.pyx'], language_level=3)
)
