% path to csv data
csvFilePath = "C:\Users\youss\Desktop\IDS-for-EV\Car_Hacking_Challenge_Dataset_rev20Mar2021\0_Preliminary\1_Submission\Pre_submit_D.csv";
% csvFilePath = "Z:\Desktop\Courses\ECE1508-Cybersecurity\final project\Car_Hacking_Challenge_Dataset_rev20Mar2021\0_Preliminary\1_Submission\Pre_submit_D.csv";

% read file
opts = detectImportOptions(csvFilePath);
opts = setvartype(opts, 'Arbitration_ID', 'char');
data = readtable(csvFilePath, opts);

matFileName = 'pre_submit_d.mat';
save(matFileName, 'data')

