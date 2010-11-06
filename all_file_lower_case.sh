#!/bin/bash

for i in * ; do mv $i `echo $i | tr [A-Z] [a-z]` ; done
