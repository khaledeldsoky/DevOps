#!/bin/bash
set -x
#   بتاعتك ع الدوكر هاب image و حط مكانها اسم  khaledmohamedatia\/node_app شيل
sed -i "s/khaledmohamedatia\/node_app:.*/khaledmohamedatia\/node_app:$2/g" $1