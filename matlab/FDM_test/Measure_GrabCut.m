function mIoU = Measure_GrabCut()
GTPath = '/home/lgy/caffe-sal/models/FDM/GrabCut_database/binary_gt/';
salPath = '/home/lgy/caffe-sal/models/FDM/GrabCut_database/sal_result/';
binaryPath = '/home/lgy/caffe-sal/models/FDM/GrabCut_database/binary_result/';
sumIoU = 0.0;
sumlengths = 0;

for i = 1001 : 1050
    name = num2str( i );
    gt = im2double(imread(fullfile(GTPath,  [name '.png'])));
    sal = im2double(imread(fullfile(salPath,  [name '.png'])));
    
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

    if ~exist(fullfile(binaryPath),'dir')
        mkdir(fullfile(binaryPath));
    end
    imwrite(sal, fullfile(binaryPath, [name '.png']));
end
mIoU = round(sumIoU/(sumlengths)*1000)/1000;
display(['mIoU = ' num2str(mIoU)  ' , Dataset sumlengths: ' num2str(sumlengths)]);
end
