#!/bin/bash

ls ITG/ > tc
ls FA+/ > te
diff tc te
rm -f tc te
