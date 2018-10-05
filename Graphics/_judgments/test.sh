#!/bin/bash

ls Competitive/ > tc
ls ECFA/ > te
diff tc te
rm -f tc te
