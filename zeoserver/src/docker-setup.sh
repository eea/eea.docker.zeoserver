#!/bin/bash

if ! test -e $ZEO_HOME/buildout.cfg; then
    python /configure.py
fi

if test -e $ZEO_HOME/buildout.cfg; then
    $ZEO_HOME/bin/buildout -c $ZEO_HOME/buildout.cfg
fi
