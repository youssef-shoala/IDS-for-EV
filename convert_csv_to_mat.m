% path to csv data
csvFilePath = "Z:\Desktop\Courses\ECE1508-Cybersecurity\final project\Car_Hacking_Challenge_Dataset_rev20Mar2021\0_Preliminary\1_Submission\Pre_submit_D.csv";

% read file
data = readtable(csvFilePath);

matFileName = 'pre_submit_d.mat';
save(matFileName, 'data')

