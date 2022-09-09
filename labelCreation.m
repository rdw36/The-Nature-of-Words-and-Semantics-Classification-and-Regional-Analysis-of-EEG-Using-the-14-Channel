data = csvread('C:\MSc\labels.csv');

j = 1;

for i = 1:200
    labels(j:j+4, 1) = data(i,1);
    j = j + 5;
end
