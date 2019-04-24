function feature = nc_temporal_dynrange(T);

% Features
% dynamic_range_high,dynamic_range_low,dynamic_range_high_count,dynamic_range_low_count,dynamic_fft_high,dynamic_fft_low;
% Dynamic Range and Power Ratios;
% 106, 108, 112 are from Robinson et al, 2009.  The rest I made up.;
% We could calculate Hz here, but since we are interested in relative;
% distances / ranges that we will normalize, the raw units are sufficient;

% compute fft;
ntime = length(T);
nfft = ntime/2;
temp = abs(fft(T, ntime));
F = temp(1:floor(ntime/2)); % just take half the spectrum (because fft is symmetric);

% Identify peak power;
[power_peak,power_x] = max(F);                      % Identify peak power;
[power_r_min,power_r_min_x ] = min(F(power_x:end)); % Identify min power at frequencies to right;
[power_l_min,power_l_min_x ] = min(F(1:power_x));   % Identify min power at frequencies to left;

% Feature 106: Dynamic Range High: difference between the peak power and minimum power at frequencies to right of peak;
feature(1) = abs(power_peak - power_r_min);
% Feature 107: Dynamic Range Low: difference between the peak power and minimum power at frequencies to left of peak;
feature(2) = abs(power_peak - power_l_min);
% Feature 108: Dynamic X Range High: difference in count of peak power and count at low frequency to right of peak;
feature(3) = abs(power_r_min_x - power_x);
% Feature 109: Dynamic X Range Low: difference in count of peak power and count at low frequency to left of peak; 
feature(4) = abs(power_l_min_x - power_x);
% Feature 110: Dynamic FFT High: difference in power*count at peak power and power*count at low frequency to right of peak; 
feature(5) = abs((power_r_min_x*power_r_min) - (power_x*power_peak));
% Feature 111: Dynamic FFT Low: difference in power*count at peak power and power*count at low frequency to left of peak; 
feature(6) = abs((power_l_min_x*power_l_min) - (power_x*power_peak));

end