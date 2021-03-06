function feature = nc_spatial_mirror(spatialMap);

    % FEATURE 9/126: MIRROR-LIKENESS OF IMAGE;
    % Percentage of mirrored voxels / all activation;
    % Create right and left data;
    xdimension = size(spatialMap,1);

    % If it's even, split data down center;
    if mod(xdimension,2) == 0;
        rightlower = (xdimension/2)+1;
        leftupper = (xdimension/2);
        rightdata = spatialMap(rightlower:end,:,:);
        leftdata = spatialMap(1:leftupper,:,:);
    else % if it's off, clip out the center slice;
        rightlower = ceil(xdimension/2)+1;
        leftupper = (xdimension-1)/2;
        rightdata = spatialMap(rightlower:end,:,:);
        leftdata = spatialMap(1:leftupper,:,:);
    end;

    % Cycle through X,Y slices (moving through Z), flip right side, and;
    % calculate overlapping voxels;
    overlap = 0;
    for z=1:size(rightdata,3);
       % flip left right, rotate 180 degrees to g;
       rightslice = squeeze(rightdata(:,:,z));
       leftslice = fliplr(rot90(squeeze(leftdata(:,:,z)),2));
       overlap = overlap + length((rightslice(:)~=0) .* (leftslice(:)~=0));
       %figure(2); subplot(2,1,1); imshow(rightslice);
       %subplot(2,1,2); imshow(leftslice);
    end;

    % If it's even, we count total voxels of activation;
    if mod(xdimension,2) == 0;
        feature = overlap / length(spatialMap(:)~=0);
    else % otherwise, we subtract activation voxels in center slice not used;
        feature = (overlap - (sum(sum(sum(((spatialMap(floor(size(spatialMap,1)/2),:,:))~=0)))))) / length(spatialMap(:)~=0);
    end;

    
end