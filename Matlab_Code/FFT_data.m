clc;close all;
fs = 22000; %采样率
N = 1024;   %采样点数
f = (1:N/2)*fs/N; %基频 步长
%%
power = 0;
corr = 1;
fft_ifft = 0;

%%
%采用归一化的相关系数表示相关性分析结果
if corr
    subplot(2,2,1);
    plot(2:N/2,FFT1(2:N/2));
    subplot(2,2,2);
    plot(2:N/2,FFT2(2:N/2));
    % 频谱db
    fft1 = 100 + 10.*log10(FFT1(1:N/2).*FFT1(1:N/2));
    subplot(2,2,3);
    plot(f,fft1);
    title('狗叫频谱');grid on;
    fft2 = 100 + 10.*log10(FFT2(1:N/2).*FFT2(1:N/2));
    subplot(2,2,4);
    plot(f,fft2);
    title('鸟叫声音频谱');grid on;
end
%%
%采用傅里叶变换进行卷积
% mfft1(1:N/2) = 100 + 10.*log10(FFT1(1:N/2).*FFT1(1:N/2));
% mfft2(1:N/2) = 100 + 10.*log10(FFT2(1:N/2).*FFT2(1:N/2));
if fft_ifft
    format long
%     FFT1(1) = 0;
%     FFT2(1) = 0;
    
    data1 = fft(FFT1);
    data2 = fft(FFT2);

    fftmux = data1(1:N/2) .* data2(1:N/2);
    subplot(2,2,1);
    plot(f(1:N/2),fftmux);
    title('FFT1 * FFT2');grid on;

    ifft_my = ifft(fftmux);
    ifft_mag = abs(ifft_my);
    subplot(2,2,2);
    plot(f,ifft_mag);
    title('IFFT 结果');grid on;
    
    fft1 = 100 + 10.*log10(data1(1:N/2).*data1(1:N/2));
    subplot(2,2,3);
    plot(f,fft1);
    title('狗叫声音频谱');grid on;
    fft2 = 100 + 10.*log10(data2(1:N/2).*data2(1:N/2));
    subplot(2,2,4);
    plot(f,fft2);
    title('狗叫声音频谱');grid on;
end 
%%
%功率谱密度：每一个频率单元的能量分布
if power
    Y_norm = FFT(1:N); % 标准化处理的FFT
    Pxx_norm = abs(Y_norm).^2; % 标准化处理的功率谱
    PSD_norm = Pxx_norm / fs; % 标准化处理的功率谱密度
    subplot(2,1,2);
    plot(f,Pxx_norm(1:N));
end                                                    
%%
%时域相乘，再积分
                         





