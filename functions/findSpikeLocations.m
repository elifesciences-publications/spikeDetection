function peaklocs = findSpikeLocations(vars,varargin)

if nargin<2 
    if isfield(vars,'filtered_data')
        filtered_data = vars.filtered_data;
    else
        error('No filtered data supplied to function ''findSpikeLocations''');
    end
else
    filtered_data = varargin{1};
end

%[peaklocs, ~] = peakfinder(filtered_data,mean(filtered_data)+vars.peak_threshold *std(filtered_data));

%[peaks, peaklocs] = findpeaks(filtered_data,'MinPeakHeight',mean(filtered_data)+vars.peak_threshold *std(filtered_data));
%[peaks, peaklocs] = findpeaks(filtered_data,'MinPeakProminence',mean(filtered_data)+vars.peak_threshold *std(filtered_data));

% [~, peaklocs] = findpeaks(filtered_data,'MinPeakProminence',mean(filtered_data)+vars.peak_threshold);
[~, peaklocs] = findpeaks(filtered_data,'MinPeakHeight',mean(filtered_data)+vars.peak_threshold,'MinPeakDistance',vars.fs/1800);
if isempty(peaklocs)
    fprintf('Nice! no peaks\n')
end

% no peak locations within a spiketemplate width of the end or beginning
peaklocs = peaklocs(peaklocs > vars.spikeTemplateWidth & peaklocs <  length(filtered_data)-vars.spikeTemplateWidth);

