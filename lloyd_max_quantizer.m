%Design of Iterative Lloyd-Max Quantizer
%Given: fx(X) = Probability Distribution Function
%       M-bit quantizer
M = 2;
img = im2double(imread('pears.jpg'));
hist = imhist(img);
fx_X = hist/max(hist);
%plot(fx_X)

%Initialise Xq and decision thresholds tq for all q = (0,1,...,(M-1))
%Generally we start with uniform quantization step
N = length(fx_X);
Xq = linspace(N/(M+1), N*M/(M+1), M);
tq = zeros(1,M+1);
tq(end) = N-1;
tq(2:end-1) = linspace((Xq(1)+Xq(2))/2, (Xq(end)+Xq(end-1))/2, M-1);
Xq = ceil(Xq);
tq = ceil(tq);
x = 1:N;
%Update the values according to Lloyd-Max Equations
iterations = 1;
for i=(1:iterations)
    for q=(1:length(Xq))
        tmp = int32(tq(q)+1:tq(q+1));
        Xq(q) = sum(x(tmp).*fx_X(tmp), 'all')/sum(fx_X(tmp),'all');
    end
    for q=(2:length(tq)-1)
        tq(q) = (Xq(q-1) + Xq(q))/2;
    end
end
Xq
plot(fx_X);
% hold on
% figure,
% plot(Xq,'x');
% plot(tq,'o');
% hold off
    