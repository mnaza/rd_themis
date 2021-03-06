#
# Copyright (c) 2016 Cossack Labs Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#!/bin/bash

test_RedisAlive() {
    res=`redis-cli ping`
    assertEquals "PONG" "$res"
}

test_Load_Rd_Themis_Module() {
    curdir=`pwd`
    res=`redis-cli module load ${curdir}/rd_themis.so`
    assertEquals "OK" "$res"
}

test_Rd_Themis_CSet() {
    res=`redis-cli rd_themis.cset test_key test_password test_data`
    assertEquals "OK" "$res"
}


test_Rd_Themis_CGet() {
    res=`redis-cli rd_themis.cget test_key test_password`
    assertEquals "test_data" "$res"
}

test_Rd_Themis_CSetBl() {
    res=`redis-cli rd_themis.csetbl test_key test_password test_data`
    assertEquals "OK" "$res"
}

test_Rd_Themis_CGetBl() {
    res=`redis-cli rd_themis.cgetbl test_key test_password`
    assertEquals "test_data" "$res"
}

test_Rd_Themis_MsSet() {
    res=`cat test/msset_command | redis-cli`
    assertEquals "OK" "$res"
}

test_Rd_Themis_MsGet() {
    res=`cat test/msget_command | redis-cli`
    assertEquals "test_data" "$res"
}

test_Rd_Themis_MsGet() {
    res=`cat test/msget_command | redis-cli`
    assertEquals "test_data" "$res"
}

test_Rd_Themis_MsGetB() {
    res=`cat test/msget_command_b | redis-cli`
    assertEquals "ERR secure message decryption failed" "$res"
}

test_Rd_Themis_MsSetBl() {
    res=`cat test/mssetbl_command | redis-cli`
    assertEquals "OK" "$res"
}

test_Rd_Themis_MsGetBl() {
    res=`cat test/msgetbl_command | redis-cli`
    assertEquals "test_data" "$res"
}

test_Rd_Themis_MsGetBlB() {
    res=`cat test/msgetbl_command_b | redis-cli`
    assertEquals "ERR secure message decryption failed" "$res"
}

test_Rd_Themis_MsGetBlB2() {
    setres=`redis-cli set test_key 1`
    assertEquals "OK" "$setres"    
    res=`cat test/msgetbl_command | redis-cli`
    assertEquals "ERR secure message decryption failed" "$res"
}

test_Rd_Themis_MsGetBlB3() {
    setres=`redis-cli del test_key`
    assertEquals "1" "$setres"    
    res=`cat test/msgetbl_command | redis-cli`
    assertEquals "0" "$res"
}

test_Unload_Rd_Themis_Module() {
    curdir=`pwd`
    res=`redis-cli module unload rd_themis`
    assertEquals "OK" "$res"
}

. shunit2
