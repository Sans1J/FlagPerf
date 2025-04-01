source /usr/local/Ascend/toolbox/set_env.sh
source /usr/local/Ascend/ascend-toolkit/set_env.sh
export LD_LIBRARY_PATH=/usr/local/Ascend/driver/lib64/driver/:$LD_LIBRARY_PATH
export INSTALL_DIR=/usr/local/Ascend/ascend-toolkit/latest
export PATH=/usr/local/mpich/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/mpich/lib:${INSTALL_DIR}/lib64:$LD_LIBRARY_PATH
export HCCL_BUFFERSIZE=4096
LOG_PATH=`pwd`
cd /usr/local/Ascend/ascend-toolkit/latest/tools/hccl_test
mpirun -n 16 ./bin/alltoall_test -b 8K -e 4G -f 2 -p 16 > ${LOG_PATH}/test_result.log 2>&1
#mpirun -n 16 ./bin/all_reduce_test -b 8K -e 4G -f 2 -p 16 > ${LOG_PATH}/test_result.log 2>&1
#mpirun -n 16 ./bin/reduce_scatter_test -b 8K -e 4G -f 2 -p 16 > ${LOG_PATH}/test_result.log 2>&1
RESULT=$(awk 'END{print $5}' ${LOG_PATH}/test_result.log)
echo "[FlagPref Result] interconnect-MPI_intraserver-bandwidth=$RESULT GB/s"
rm -rf ${LOG_PATH}/test_result.log