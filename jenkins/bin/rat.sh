#!/bin/sh
#
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

set -x

cd "${WORKSPACE}/src"

autoreconf -if && ./configure

# WTF
rm -f lib/ts/stamp-h1

${ATS_MAKE} rat | tee RAT.txt
#mv RAT.txt /CA/RAT/rat-${ATS_BRANCH}.txt.new
#mv /CA/RAT/rat-${ATS_BRANCH}.txt.new /CA/RAT/rat-${ATS_BRANCH}.txt

# Purgatory
#curl -o /dev/null -k -s -X PURGE https://ci.trafficserver.apache.org/RAT/rat-${ATS_BRANCH}.txt

# Mark as failed if there are any unknown licesnes
#grep '0 Unknown Licenses' /CA/RAT/rat-${ATS_BRANCH}.txt >/dev/null || exit 1
grep '0 Unknown Licenses' RAT.txt >/dev/null || exit 1

# Normal exit
exit 0
