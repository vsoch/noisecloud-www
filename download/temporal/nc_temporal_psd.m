function feature = nc_temporal_psd(T);

    % Calculate FFT of timeseries;
    F = abs(fft(T,length(T)));

    % Feature 24 to end: Power Spectrum Density, all frequencies;
    Hpsd = dspdata.psd(F(1:83),'Spectrumtype','Onesided');
    feature = Hpsd.Data';

end