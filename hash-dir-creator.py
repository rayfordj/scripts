#!/usr/bin/python2

import datetime
import errno
import hashlib
import os
import sys

# md5
# sha1
# sha256
# sha512

# set default values 
# datetime.now() simple enough to be unique
data = str(datetime.datetime.now())
hash_def = 'sha256'
# the chunk size (split chars at this)
step = 6

# create a hash using defined hash and data string
def _hashit(hash_name,data):
    m = hashlib.new(hash_name)
    m.update(data)
    return m.hexdigest()


# split the data at 'step' characters and put in list
def _split_by_n(data,n):
    while data:
        yield data[:n]
        data = data[n:]

# directory-ize it by appending '/' while iterating list to string
def _ize_it(datalist):
    ized = ''
    for li in datalist:
        ized = ized + li + '/'
    return ized

# create dir structure
def _make_path(path):
    try:
        os.makedirs(path,0751)
        os.chmod(path,0755)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise

# see if we were passed any args and use them to override if so
try: 
    hash_name = sys.argv[1]
except IndexError:
    hash_name = hash_def
else:
    try:
        data = sys.argv[2]
    except IndexError:
        data = str(datetime.datetime.now())

# make it reality
_make_path(_ize_it(list(_split_by_n(_hashit(hash_name,data),step))))


