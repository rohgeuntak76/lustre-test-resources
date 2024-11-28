#!/bin/bash

pcs constraint location MGS prefers testoss1=100
pcs constraint location test-MDT0000 prefers testoss1=50
pcs constraint location test-MDT0001 prefers testoss1=100
pcs constraint location test-OST0000 prefers testoss1=50
pcs constraint location test-OST0001 prefers testoss1=100
pcs constraint location test-OST0002 prefers testoss1=50
pcs constraint location test-OST0003 prefers testoss1=100

pcs constraint location MGS prefers testoss2=50
pcs constraint location test-MDT0000 prefers testoss2=100
pcs constraint location test-MDT0001 prefers testoss2=50
pcs constraint location test-OST0000 prefers testoss2=100
pcs constraint location test-OST0001 prefers testoss2=50
pcs constraint location test-OST0002 prefers testoss2=100
pcs constraint location test-OST0003 prefers testoss2=50
