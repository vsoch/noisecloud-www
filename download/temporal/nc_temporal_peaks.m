function feature = nc_temporal_peaks(T);

    % Features;
    % number_local_max,number_local_min,average_amplitude,avg_dist_btw_max_peaks,avg_dist_btw_min_peaks,biggest_jump_ts,average_jump_ts,max_value_ts,min_value_ts;
    % FEATURE 3-5 number peaks, number mins, average amplitude over time;
    [max_value,max_index] = max(T); [min_value,min_index] = min(T);

    % Find the local max and min values of the timeseries;
    maxindex = findpeaks(T);
    minindex = findpeaks(-T);

    local_max = zeros(1,length(maxindex.loc));
    local_min = zeros(1,length(minindex.loc));

    for i=1:length(maxindex.loc);
        local_max(i) = T(maxindex.loc(i));
    end;
    for i=1:length(minindex.loc);
        local_min(i) = T(minindex.loc(i));
    end;
    
    % FEATURE 3: number of local max (peaks);
    numpeaks = length(maxindex.loc);
    feature(1) = numpeaks / length(T);

    % FEATURE 4: number of local mins;
    nummins = length(minindex.loc);
    feature(2) = nummins / length(T);

    % Calculate average min peak and average max peak, take difference to get;
    % avg amplitude;
    avg_amplitude = mean(local_max) - mean(local_min);
    
    % FEATURE 5: Average Amplitude;
    feature(3) = avg_amplitude;
    
    % Calculate max and min values, then find average distance between them;
    maxindex = maxindex.loc;
    minindex = minindex.loc;
    min_y = T(minindex);
    max_y = T(maxindex);

    maxindexcopy = [0; maxindex]; minindexcopy = [0; minindex];

    for i=1:length(maxindex);
        difference_max(i) =  maxindex(i) - maxindexcopy(i);
    end;
    for i=1:length(minindex);
        difference_min(i) = minindex(i) - minindexcopy(i);
    end;

    % Feature 6, average distance between maximum peaks;
    mean_max_dist = mean(difference_max);
    feature(4) = mean_max_dist;
    
    % Feature 7, average distance between minimum peaks;
    mean_min_dist = mean(difference_min);
    feature(5) = mean_min_dist;

    % Put min and max values and indices into one vector;
    % First figure out which array has the lowest value, this will be the;
    % first type when we sort the arrays;

    % If the min value is less than or = to max, it is first in the sorted list;
    % otherwise, the max value is first in the list, and the remaining values;
    % fluctuate min,max,min,max,etc.;
    minmax = [min_y; max_y];
    minmaxindex = [minindex; maxindex];
    [~,indices_forminmax] = sort(minmaxindex);

    for i=1:length(minmax)-1;
        contendervalue(i) = abs(minmax(indices_forminmax(i+1)) - minmax(indices_forminmax(i)));
        % contendervalue(i) = abs(T(minmaxindex(i+1)) - T(minmaxindex(i)));
    end;
    
    %---------------------------------------------------------------------;
    % FEATURES 8-9: measuring change;
    % Feature 8, biggest jump;
    feature(6) = max(contendervalue);
    % Feature 9, average jump;
    feature(7) = mean(contendervalue);

    % Minimum and maximum values;
    feature(8) = max_value;
    feature(9) = min_value;

end