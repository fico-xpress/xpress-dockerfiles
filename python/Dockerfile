############################################################################
#
#  (c) Copyright 2018 Fair Isaac Corporation
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
############################################################################

ARG PYTHON_VERSION="3.12"
FROM python:${PYTHON_VERSION}-slim-bullseye
ARG XPRESS_VERSION="9.5.3"
LABEL version="${XPRESS_VERSION}"

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y ca-certificates \
    && update-ca-certificates \
    && python -m pip install xpress==${XPRESS_VERSION} \
    && rm -rf /var/lib/apt/lists/*

CMD ["python"]