function feature = nc_temporal_energyratio(T);

    global TR;

    % Calculate FFT of timeseries;
    freq_data = abs(fft(T,length(T)));

    % FEATURE 112: Ratio of the integral of spectral power below 0.10 Hz to;
    % the integral of power between 0.15 and 0.25 Hz;
    % Integral just means the area under the curve I think :O);
    ntime = length(T);
    nfft = ntime/2;

    % Set spectral power min, middle, and high values;
    spectral_Hz_min = 0.10;
    spectral_Hz_mid = 0.15;
    spectral_Hz_max = 0.25;

    spectral_min_index = round(nfft*spectral_Hz_min)/(1/(2*TR));
    spectral_mid_index = round(nfft*spectral_Hz_mid)/(1/(2*TR));    
    spectral_max_index = round(nfft*spectral_Hz_max)/(1/(2*TR));    

    % compute energy in the lower range bucket (below 0.10);
    low_bucket_energy = 0;
    for column = 1:spectral_min_index-1;
        low_bucket_energy = low_bucket_energy + freq_data(column)^2;
    end;

    % compute energy in the higher range bucket (0.15 to 0.25);
    high_bucket_energy = 0;
    for column = spectral_mid_index:spectral_max_index-2;
        high_bucket_energy = high_bucket_energy + freq_data(column)^2;
    end;

    % Low frequency to high power ratio;
    feature = abs(low_bucket_energy / high_bucket_energy);
    
end