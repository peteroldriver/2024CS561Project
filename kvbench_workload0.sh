#!/bin/bash
INDEX_LIST=("0" "1" "2")
I_LIST=("1000000" "2000000" "5000000")
Q_LIST=("500000"  "1000000" "2500000")
U_LIST=("500000"  "1000000" "2500000")
D_LIST=("500000"  "1000000" "2500000")
E="1024"
UD_LIST=("0" "1" "2" "3")
ED_LIST=("0" "1" "2" "3")

output_file="output.txt"  # Name of the output file

echo "Delete Test: "
echo "" >> $output_file
for i in ${INDEX_LIST[@]}
do
    for ed in ${ED_LIST[@]}
    do
        cmd="./load_gen -I ${I_LIST[i]} -Q ${Q_LIST[i]} -D ${D_LIST[i]} --ED=${ED_LIST[ed]}"
        echo "$cmd" >> $output_file  # Appending the command to the file
        script -a -c "$cmd" $output_file  # Running the command and appending its output to the file
    done
done

echo "Update Test: "
echo "" >> $output_file
for i in ${INDEX_LIST[@]}
do
    for ud in ${UD_LIST[@]}
    do
        cmd="./load_gen -I ${I_LIST[i]} -U ${Q_LIST[i]} -D ${D_LIST[i]} --UD=${UD_LIST[ud]}"
        echo "$cmd" >> $output_file  # Appending the command to the file
        script -a -c "$cmd" $output_file  # Running the command and appending its output to the file
    done
done

echo "MIX WorkLOAD Test: "
echo "" >> $output_file
for i in ${INDEX_LIST[@]}
do
    cmd="./load_gen -I ${I_LIST[i]} -U ${Q_LIST[i]} -D ${D_LIST[i]} -Q${Q_LIST[i]} --UD=3 --ED=3"
    echo "$cmd" >> $output_file  # Appending the command to the file
    script -a -c "$cmd" $output_file  # Running the command and appending its output to the file
done
echo "" >> $output_file
for i in ${INDEX_LIST[@]}
do
    cmd="./load_gen -I ${I_LIST[i]} -U ${Q_LIST[i]} -D ${D_LIST[i]} -Q${Q_LIST[i]} --UD=2 --ED=2"
    echo "$cmd" >> $output_file  # Appending the command to the file
    script -a -c "$cmd" $output_file  # Running the command and appending its output to the file
done
echo "" >> $output_file
for i in ${INDEX_LIST[@]}
do
    cmd="./load_gen -I ${I_LIST[i]} -U ${Q_LIST[i]} -D ${D_LIST[i]} -Q${Q_LIST[i]} --UD=1 --ED=1"
    echo "$cmd" >> $output_file  # Appending the command to the file
    script -a -c "$cmd" $output_file  # Running the command and appending its output to the file
done
