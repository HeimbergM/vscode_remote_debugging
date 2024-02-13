#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
while read var value
do
    export "$var"="$value"
done < $SCRIPT_DIR/config.conf

# python args
# arg1="Python"
arg2="--converter_config /work/dlclarge2/heimberm-masterprojekt/SportPose/configs/modules/data/data_converter/moyo_data_converter_wo_perception.py --overwrite"

cd $WORKDIR
source $CONDA_SOURCE
conda activate $CONDA_ENV
python -m debugpy --listen 0.0.0.0:$PORT --wait-for-client $WORKDIR/SportPose/tools/prepare_dataset.py $arg1 $arg2
conda deactivate