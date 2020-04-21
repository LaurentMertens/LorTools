from setuptools import setup, find_packages

setup(
    python_requires='>=3.6',
    name='lor-tools',
    version='1.0',
    packages=find_packages(exclude=['tests']),
    url='',
    license='MIT',
    author='Laurent Mertens',
    author_email='laurent.mertens@outlook.com',
    description='A collection of tools that, either explicitly or implicitly, use binary search.',
    install_requires=[]
)
