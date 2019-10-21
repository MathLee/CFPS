function mIoU = Measure_FDM()
load('/home/lgy/caffe-sal/models/FDM/OSIE/True_GT_N.mat');
GTPath = '/home/lgy/caffe-sal/models/FDM/OSIE/GT_N/';
salPath = '/home/lgy/caffe-sal/models/FDM/OSIE/FDM_test/';
binaryPath = '/home/lgy/caffe-sal/models/FDM/OSIE/binary_FDM_test/';
sumIoU = 0.0;
sumlengths = 0;

for i = 3076 : 3683
    name = num2str( True_GT(i,1) );
    FDMname = num2str( True_GT(i,2) );
    gt = im2double(imread(fullfile(GTPath, name, [FDMname '.png'])));
    sal = im2double(imread(fullfile(salPath, name, [FDMname '.png'])));
    threshold = graythresh(sal);
    sal = ( sal > threshold );
    sal = double(sal);
    pointproduct=gt.*sal;
    pointadd=gt+sal;
    I=sum(pointproduct(:));
    U=sum(pointadd(:)>=1);
    IoU=I/U;
    sumIoU=sumIoU+IoU;
    sumlengths = sumlengths + 1;
    if ~exist(fullfile(binaryPath, name),'dir')
        mkdir(fullfile(binaryPath, name));
    end
    imwrite(sal, fullfile(binaryPath, name, [FDMname '.png']));
end
mIoU = round(sumIoU/(sumlengths)*1000)/1000;
display(['mIoU = ' num2str(mIoU)  ' , Dataset sumlengths: ' num2str(sumlengths)]);
end
