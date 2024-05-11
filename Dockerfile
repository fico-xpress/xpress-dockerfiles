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

FROM ubuntu:20.04 as optimizer
ARG COMPONENTS

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y libncurses5 \
	&& rm -rf /var/lib/apt/lists/*

ENV XPRESSTMP=/tmp/xpressmp \
	XPRESSDIR=/opt/xpressmp

ENV XPAUTH_PATH=${XPRESSDIR}/bin/xpauth.xpr \
	LD_LIBRARY_PATH=${XPRESSDIR}/lib:${LD_LIBRARY_PATH} \
	CLASSPATH=${XPRESSDIR}/lib/xprs.jar:${CLASSPATH} \
	CLASSPATH=${XPRESSDIR}/lib/xprb.jar:${CLASSPATH} \
	CLASSPATH=${XPRESSDIR}/lib/xprm.jar:${CLASSPATH} \
	PATH=${XPRESSDIR}/bin:${PATH}

COPY install.sh ${XPRESSTMP}/install.sh
COPY kalis_license.txt ${XPRESSTMP}/kalis_license.txt
COPY xp*.tar.gz ${XPRESSTMP}/xpress.tar.gz

# User accepts kalis Terms & Conditions by using option `--accept-kalis-license`
# User also accepts Xpress shrinkwrap license by using option `--accept-xpress-license`
RUN cd ${XPRESSTMP} \
    && bash install.sh $(if [ -n "$COMPONENTS" ]; then echo "--components ${COMPONENTS}"; fi) $(if $(echo "$COMPONENTS" | tr "," "\n" | grep -Fxq "kalis"); then  echo "--accept-kalis-license"; else echo ""; fi) --license-type community --include-in-bashrc --accept-xpress-license --no-interactive --install-path ${XPRESSDIR} \
    && cd - \
    && rm -rf ${XPRESSTMP}

# Xpress is now fully installed and configured.
# Depending on what you actually want to do in your container,
# this may be a good time to create a non-privileged user and switch to that account.
