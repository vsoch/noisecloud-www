function feature = nc_spatial_degreecluster(spatialMap);

    % Features are:;
    % 'mean_cluster_size,min_cluster_size,max_cluster_size;
    
    % FEATURE 6-8/122-125: Degree of Clustering, measure of spatial structure of a;
    % component.  We will calculate top 10 local max, then do region;
    % growing at a threshold of 2.5, then get cluster sizes for clusters;
    % that have less than 50% overlap, and take an average, min, and max;
    
    [Maxima,MaxPos,~,~] = MinimaMaxima3D(spatialMap,1,0,10,0);
    
    % For each local maxima, use region growing to get size of cluster;
    for m = 1:size(MaxPos,1);
        xcoord = MaxPos(m,1);
        ycoord = MaxPos(m,2);
        zcoord = MaxPos(m,3);
        % We will set a minimum threshold of 2.5, as did de Martino;
        % The maximum size of the cluster is max(size(spatialMap));
        % P is like a mask of the cluster, and J is the voxel coordinates;
        [P{m}, J{m}] = regionGrowing(spatialMap, [xcoord,ycoord,zcoord], 2.5, max(size(spatialMap)), 0, 0, 0);
    end;

    % For pairwise local maxes, find the "unique" ones that have less than 50% overlap;
    unique_regions = [1 2 3 4 5 6 7 8 9 10]; % Start with all local maxes;
 
    if exist('P','var');
        % We now want to get a sense of the average cluster size.  We will;
        % first calculate the average cluster size:;
        avg_cluster_sizes = zeros(min(length(unique_regions),length(P)),1);
        for m = 1:min(length(unique_regions),length(P));
            avg_cluster_sizes(m) = size(P{unique_regions(m)},1); 
        end;
        feature(1) = mean(avg_cluster_sizes);
        feature(2) = min(avg_cluster_sizes);
        feature(3) = max(avg_cluster_sizes);    
    else;
        feature(1) = 0;
        feature(2) = 0;
        feature(3) = 0;
    end;
end