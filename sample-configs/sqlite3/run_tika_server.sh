#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# ---------------------
# Download tika-sqlite3
# ---------------------

SQLITE3_LOCATION="/sqlite3"
URL="https://dlcdn.apache.org/tika/2.7.0/tika-parser-sqlite3-package-${TIKA_VERSION}.jar"

mkdir -p $SQLITE3_LOCATION/parser
if [ "$(ls -A $SQLITE3_LOCATION/*.jar)" ]; then
    echo "Sqlite3 directory has files, so skipping fetch";
else
	echo "No Sqlite3 found, so fetching parser"
	wget "$URL" -O $SQLITE3_LOCATION/parser/tika-parser-sqlite3-package-${TIKA_VERSION}.jar
fi

# -------------------
# Now run Tika Server
# -------------------

# Set classpath to the Tika Server JAR and the /sqlite3 folder so it has the configuration from above
CLASSPATH="$SQLITE3_LOCATION/parser/tika-parser-sqlite3-package-${TIKA_VERSION}.jar:/tika-server-standard-${TIKA_VERSION}.jar:/tika-extras/*"
# Run the server
exec java -cp $CLASSPATH org.apache.tika.server.core.TikaServerCli -h 0.0.0.0
