function feature = nc_temporal_highfreqnoise(T);

    % Calculating FFT from timeseries, and calculating high frequency noise;
    % as noise above some percent threshold (25);
    HFInitIndex = 25;

    % Calculate FFT of timeseries;
    freq_data = abs(fft(T,length(T)));

    % Now calculate high frequency noise as a percentage of total energy. Too;
    % much high frequency noise is likely a bad component, but we will use this;
    % percentage as a feature. Keep track of the following;
    total_energy = 0; high_freq_noise = 0;

    % Determine high frequency noise energy;
    for j = HFInitIndex:length(freq_data);
        high_freq_noise = high_freq_noise + (freq_data(j) * freq_data(j));
    end;

    % Determine total energy and energy percent. We will start by summing the;
    % frequencies up until the threshold, and then add to the high_freq_noise;
    % to get a total, and then calculate high_freq_noise as a % of total;
    for j = 1:HFInitIndex;
        total_energy = total_energy + (freq_data(j) * freq_data(j));
    end;

    % In Kaustubh's implementation, we would check if this % noise is;
    % greater than some threshold, and use that as a flag.  If the %-age;
    % high frequency noise was > 50, this was considered a "bad" component.;
    total_energy = total_energy + high_freq_noise;

    %--------------------------------------------------------------------;
    % FEATURE 1: Percentage of total energy that is "high frequency";
    % meaning it is above a user specified threshold (25 = X HZ);
    energy_percent = 100 * (high_freq_noise / total_energy);
    feature = energy_percent;  
    
end