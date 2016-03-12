#!/bin/bash

cat ~/.i3/conf.d/* > ~/.i3/config
i3-msg reload
