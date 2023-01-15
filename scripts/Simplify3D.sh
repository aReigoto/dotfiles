#!/usr/bin/env bash

# 2. Add "127.0.0.1 api.simplify3d.com" to /etc/hosts for disabling Login.

# Simplify3D_FOLDER='/Applications/Simplify3D-4.0.0'
Simplify3D_FOLDER='/Applications/Simplify3D-4.0.1'

cd $Simplify3D_FOLDER

DYLD_INSERT_LIBRARIES=./Interface.dylib DYLD_FORCE_FLAT_NAMESPACE=1 ./Simplify3D.app/Contents/MacOS/Simplify3D

#'DYLD_INSERT_LIBRARIES=./Interface.dylib:/System/Library/Frameworks/OpenGL.framework/Resources/GLEngine.bundle/GLEngine DYLD_FORCE_FLAT_NAMESPACE=1 ./Simplify3D.app/Contents/MacOS/Simplify3D'
